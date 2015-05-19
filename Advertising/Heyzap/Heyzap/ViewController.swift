//
//  ViewController.swift
//  Heyzap
//
//  Created by tommy trojan on 5/16/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    func showBannerAd(){
        println("bannerAds:")
        let options = HZBannerAdOptions()
        HZBannerAd.placeBannerInView(self.view, position: HZBannerPosition.Bottom, options:options, success: {(banner) in
            
            }, failure: {(error) in
                println("Error is \(error)")
        })
    }
    
    func showInterstitialAd(){
        HZInterstitialAd.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showBannerAd()
        showInterstitialAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

