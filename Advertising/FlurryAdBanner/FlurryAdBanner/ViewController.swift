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

import UIKit
import SystemConfiguration

class ViewController: UIViewController, FlurryAdInterstitialDelegate {

    
    @IBAction func showBanner(sender: AnyObject) {
    }
    
    @IBAction func showInterstitial(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch and display banner ad for a given ad space. Note: Choose an adspace name that
        // will uniquely identifiy the ad's placement within your app
    }
    
    override func viewDidAppear(animated: Bool) {
        let adBanner = FlurryAdBanner(space: "MyFirstCampaign")
        adBanner.adDelegate = self
        adBanner.fetchAndDisplayAdInView(self.view, viewControllerForPresentation: self)

        var adInterstitial = FlurryAdInterstitial(space: "KUSC iOS Download")
        adInterstitial.adDelegate = self
        adInterstitial.targeting = FlurryAdTargeting()
        if adInterstitial.ready{            
            adInterstitial.presentWithViewController(self)
        }else{
            adInterstitial.fetchAd()
        }
    }
    
    func adInterstitialWillPresent(interstitialAd: FlurryAdInterstitial!) {
        //Pause app stere here
        println("adInterstitialWillPresent")
    }
    func adInterstitialWillDismiss(interstitialAd: FlurryAdInterstitial!) {
        //Resume app state here
        println("adInterstitialWillDismiss")
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

extension ViewController: FlurryAdBannerDelegate{
    //Invoked when an ad is received for the specified bannerAd object.
    func adBannerDidFetchAd(bannerAd: FlurryAdBanner!) {
        println("adBannerDidFetchAd")
    }
    
    //Invoked when the banner ad is rendered.
    func adBannerDidRender(bannerAd: FlurryAdBanner!) {
        println("adBannerDidRender")
    }
    
    //Informational callback invoked when an ad is clicked for the specified @c bannerAd object.
    func adBannerDidReceiveClick(bannerAd: FlurryAdBanner!) {
        println("adBannerDidReceiveClick")
    }

    //Informational callback invoked when there is an ad error
    func adBanner(bannerAd: FlurryAdBanner!, adError: FlurryAdError, errorDescription: NSError!) {
        println("adBanner")
    }
}

