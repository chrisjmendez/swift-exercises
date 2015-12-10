//
//  ViewController.swift
//  Interstitial
//
//  Created by Tommy Trojan on 10/28/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADInterstitialDelegate {

    var interstitial: GADInterstitial?
    var timer:NSTimer?
    
    func createAndLoadInterstitial() -> DFPInterstitial {
        let request = DFPRequest()
            //This shows AdMob ads
            //request.testDevices = [kGADSimulatorID]
        let ads = ["/181024612/2015_fall_320x480"]
        //let randomNumber = Int.random(0...1)
        let interstitial = DFPInterstitial(adUnitID: ads[0])
            //Register the Interstitial events
            interstitial.delegate = self
            interstitial.loadRequest(request)
        
        return interstitial
    }
    
    func showInterstitial(){
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .LongStyle)
        print("showInterstitial \(timestamp)")
        if (interstitial!.isReady) {
            interstitial!.presentFromRootViewController(self)
        }
    }
    
    // /////////////////////////////////////////////
    // Events
    // /////////////////////////////////////////////
    //Tells the delegate that the full screen view has been dismissed.
    func interstitialDidDismissScreen(ad: GADInterstitial!) {
        print("User closed AD")
        //Create a new Interstitial
        interstitial = createAndLoadInterstitial()
    }
    //Tells the delegate an ad request loaded an ad.
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        print("Ad was received")
        //Delay the presentation by a few seconds
        startTimer(0.5)
    }
    //Tells the delegate that a user click will open another app
    func interstitialWillLeaveApplication(ad: GADInterstitial!) {
        print("User will leave app")
    }
    //The screen will present the ad
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        print("Ad is being presented")
    }

    
    // /////////////////////////////////////////////
    // Simple Timer
    // /////////////////////////////////////////////
    func startTimer(delay:Double){
        let delayTime = delay
        timer = NSTimer.scheduledTimerWithTimeInterval(delayTime, target: self, selector: "showInterstitial", userInfo: nil, repeats: false)
    }
    
    func stopTimer(){
        timer = nil
    }
    
    // /////////////////////////////////////////////
    // On Load
    // /////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        interstitial = createAndLoadInterstitial()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
