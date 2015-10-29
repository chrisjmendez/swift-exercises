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
    
    func createAndLoadInterstitial() -> DFPInterstitial {
        let interstitial = DFPInterstitial(adUnitID: "/6499/example/interstitial")
            interstitial.delegate = self
            interstitial.loadRequest(DFPRequest())
        
        return interstitial
    }
    
    func showInterstitial(){
        print("showInterstitial")
        if (interstitial!.isReady) {
            interstitial!.presentFromRootViewController(self)
        }
    }
    
    func interstitialDidDismissScreen(ad: GADInterstitial!) {
        self.interstitial = createAndLoadInterstitial()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.interstitial = createAndLoadInterstitial()
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "showInterstitial", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

