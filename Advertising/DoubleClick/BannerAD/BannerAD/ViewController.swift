//
//  ViewController.swift
//  BannerAD
//
//  Created by Tommy Trojan on 10/28/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet weak var bannerView: DFPBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         print("Google Mobile Ads SDK version: " + DFPRequest.sdkVersion())
        
         bannerView.adUnitID = "/6499/example/banner"
         bannerView.rootViewController = self
          bannerView.loadRequest(DFPRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

