//
//  ViewController.swift
//  FlurryAdBanner
//
//  Created by tommy trojan on 5/27/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

//https://developer.yahoo.com/flurry/docs/publisher/code/ios/
//https://github.com/flurrydev/FlurryIntegrationSamples-iOSV6
//https://developer.yahoo.com/flurry/

/*
Before you start, you first want to create an AD Space. 
https://dev.flurry.com/appSpotSignup.do
Once you're done with that, then you can offer an Interstitial AD
*/

import Foundation
import UIKit
import SystemConfiguration

class ViewController: UIViewController, FlurryAdBannerDelegate, FlurryAdInterstitialDelegate {

    var bannerAdPlist:String?
    var flurryBannerAdSpaces:NSArray?
    var bannerAdSpaceName:String?
    var adBanner:FlurryAdBanner?

    var interstitialAdPlist:String?
    var flurryInterstitialAdSpaces:NSArray?
    var interstitialAdSpaceName:String?
    var adInterstitial:FlurryAdInterstitial?
    
    //        let plistFile:String = NSBundle.mainBundle().pathForResource("StreamAdSpaceList", ofType: "plist")!

    
    var adTargeting:FlurryAdTargeting?

    var randomIdx:Int?
    
    @IBAction func showBanner(sender: AnyObject) {
        println("showBanner + \(bannerAdSpaceName!)")
        fetchandDisplayBannerAd(bannerAdSpaceName!)
    }
    
    @IBAction func showInterstitial(sender: AnyObject) {
        println("showInterstitial + \(interstitialAdSpaceName!)")
        //If the adInterstitial has been invocated and qeued up, show it!
        if adInterstitial!.ready{
            adInterstitial?.presentWithViewController(self)
        }else{
            adInterstitial?.fetchAd()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch and display banner ad for a given ad space. Note: Choose an adspace name that
        // will uniquely identifiy the ad's placement within your app

        //A. Parse the Plist File
        bannerAdPlist = NSBundle.mainBundle().pathForResource("BannerAdSpaceList", ofType: "plist")
        //B. Convert the plist conents to an array of Ad Spaces from Flurry
        flurryBannerAdSpaces = NSArray(contentsOfFile: bannerAdPlist!)
        //C. Pick a random number
        randomIdx = Int.random(0...(flurryBannerAdSpaces!.count-1))
        //C.1. Look at BannderAdSpace
        //D. Pick a random ad from within B.
        bannerAdSpaceName = flurryBannerAdSpaces?.objectAtIndex(randomIdx!) as? String
      
        //A. Load and Parse
        interstitialAdPlist = NSBundle.mainBundle().pathForResource("InterstitialAdSpaceList", ofType: "plist")
        //B. Convert
        flurryInterstitialAdSpaces = NSArray(contentsOfFile: interstitialAdPlist!)
        //C. Randomize
        randomIdx = Int.random(0...(flurryInterstitialAdSpaces!.count-1))
        //C.1. Look at InterstitialAdSpaceList.plist
//        randomIdx = 7
        //D. Pick an ad
        interstitialAdSpaceName = flurryInterstitialAdSpaces?.objectAtIndex(randomIdx!) as? String
        //E. Fetch the ad and cache it
        fetchAndDisplayInterstitialAd(interstitialAdSpaceName!)
        
    }

    func fetchandDisplayBannerAd(name:String){
        
        adBanner = FlurryAdBanner(space: name)
        
        adBanner?.adDelegate = self
        
        adBanner?.fetchAndDisplayAdInView(self.view, viewControllerForPresentation: self)
        //adBanner?.fetchAdForFrame(self.view.frame)
    }
    
    func fetchAndDisplayInterstitialAd(name:String){
        adInterstitial = FlurryAdInterstitial(space: name)
        
        adInterstitial?.adDelegate = self
        
        adInterstitial?.fetchAd()
        
        //!!! Turn this off for development
        testMode(bool: true)
    }
    
    func testMode(bool:Bool=false){
        adTargeting = FlurryAdTargeting()
        adTargeting?.testAdsEnabled = bool
        adInterstitial?.targeting = adTargeting
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear:")
    }
    
    override func viewDidDisappear(animated: Bool) {
        // Do not set ad delegate to nil and
        // Do not remove ad in the viewWillDisappear or viewDidDisappear method
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: FlurryAdBannerDelegate {
    //Invoked when an ad is received for the specified bannerAd object.
    func adBannerDidFetchAd(bannerAd: FlurryAdBanner!) {

        println("Banner AD: \(bannerAd.space) did fetch AD")
        
        bannerAd.displayAdInView(self.view, viewControllerForPresentation: self)
    }
    
    //Invoked when the banner ad is rendered.
    func adBannerDidRender(bannerAd: FlurryAdBanner!) {
        println("Banner AD: \(bannerAd.space) rendered and is ready for display")
    }
    
    //Informational callback invoked when an ad is clicked for the specified @c bannerAd object.
    func adBannerDidReceiveClick(bannerAd: FlurryAdBanner!) {
        println("Banner AD: \(bannerAd.space) did receive click")
    }

    //Informational callback invoked when there is an ad error
    func adBanner(bannerAd: FlurryAdBanner!, adError: FlurryAdError, errorDescription: NSError!) {
        println("Banner AD: \(bannerAd.space) received an ad error \(adError), \(errorDescription.description)")
    }
}

extension ViewController: FlurryAdInterstitialDelegate{
    func adInterstitialDidFetchAd(interstitialAd: FlurryAdInterstitial!) {
        println("Ad Space: \(interstitialAd.space) received and is available")
    }
    
    func adInterstitialDidRender(interstitialAd: FlurryAdInterstitial!) {
        println("Ad Space: \(interstitialAd.space) is rendered and ready for display")
    }
    
    func adInterstitialWillPresent(interstitialAd: FlurryAdInterstitial!) {
        //Pause app stere here
        println("Ad Space: \(interstitialAd.space) will present.")
    }
    
    func adInterstitialWillDismiss(interstitialAd: FlurryAdInterstitial!) {
        //Resume app state here
        println("Ad Space: \(interstitialAd.space) will dismiss for interstitial")
    }
    
    func adInterstitialVideoDidFinish(interstitialAd: FlurryAdInterstitial!) {
        println("Video \(interstitialAd.space) Finished Playing")
    }
    
    func adInterstitialDidReceiveClick(interstitialAd: FlurryAdInterstitial!) {
        println("Ad Space: \(interstitialAd.space) Did Receive Click")
    }
    
    func adInterstitialWillLeaveApplication(interstitialAd: FlurryAdInterstitial!) {
        println("Ad Space: \(interstitialAd) Will leave application")
    }
    
    func adInterstitial(interstitialAd: FlurryAdInterstitial!, adError: FlurryAdError, errorDescription: NSError!) {
        println("Ad Space: \(interstitialAd.space) failed and received an Ad with error \(adError), \(errorDescription.description)")
    }
}

extension Int{
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
