//
//  ViewController.swift
//  BasicBannerAd
//
//  Created by Tommy Trojan on 10/6/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController: UIViewController {

    @IBOutlet weak var bannerView: DFPBannerView!
    
    func loadBanner(){
        bannerView.adUnitID = "/6499/example/banner"
        //Setting this view controller is used to present an overlay
        bannerView.rootViewController = self
        //
        bannerView.loadRequest( DFPRequest() )
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Google Mobile Ads SDK version: " + DFPRequest.sdkVersion() )
        loadBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

