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
    var timer:Timer?
    
    func createAndLoadInterstitial() -> DFPInterstitial {
        let request = DFPRequest()
            //This shows AdMob ads
            request.testDevices = [kGADSimulatorID]
        let ads = ["/181024612/2015_fall_320x480"]
        //let randomNumber = Int.random(0...1)
        let interstitial = DFPInterstitial(adUnitID: ads[0])
            //Register the Interstitial events
            interstitial.delegate = self
            interstitial.load(request)
        
        return interstitial
    }
    
    func showInterstitial(){
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .long)
        print("showInterstitial \(timestamp)")
        if (interstitial!.isReady) {
            interstitial!.present(fromRootViewController: self)
        }
    }
    
    // /////////////////////////////////////////////
    // Events
    // /////////////////////////////////////////////
    //Tells the delegate that the full screen view has been dismissed.
    func interstitialDidDismissScreen(_ ad: GADInterstitial!) {
        print("User closed AD")
        //Create a new Interstitial
        interstitial = createAndLoadInterstitial()
    }
    //Tells the delegate an ad request loaded an ad.
    func interstitialDidReceiveAd(_ ad: GADInterstitial!) {
        print("Ad was received")
        //Delay the presentation by a few seconds
        startTimer(0.5)
    }
    //Tells the delegate that a user click will open another app
    func interstitialWillLeaveApplication(_ ad: GADInterstitial!) {
        print("User will leave app")
    }
    //The screen will present the ad
    func interstitialWillPresentScreen(_ ad: GADInterstitial!) {
        print("Ad is being presented")
    }

    
    // /////////////////////////////////////////////
    // Simple Timer
    // /////////////////////////////////////////////
    func startTimer(_ delay:Double){
        let delayTime = delay
        timer = Timer.scheduledTimer(timeInterval: delayTime, target: self, selector: #selector(ViewController.showInterstitial), userInfo: nil, repeats: false)
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
    static func random(_ range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
