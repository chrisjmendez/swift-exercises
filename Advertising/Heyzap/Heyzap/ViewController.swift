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

    var timer:NSTimer = NSTimer()
    var counter = 30
    let durationBetweenAds = 30
    
    @IBOutlet weak var countdownTxt: UILabel!
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("counterUpdater"), userInfo: nil, repeats: true)
    }
    func stopTimer(){
        timer.invalidate()
    }
    
    func resetTimer() {
        timer.invalidate()
        counter = durationBetweenAds
        countdownTxt.text = String(durationBetweenAds)
        startTimer()
    }
    
    func counterUpdater(){
        println("counterUpdater")
        countdownTxt.text = String(counter--)
        if( counter == 0 ){
            selectAD()
            resetTimer()
        }
    }
    
    //I'm only picking 1 banner ad for now
    func selectAD(){
        var randomNumber = Int.random(0...2)
            randomNumber = 0
        switch(randomNumber){
        case 0:
            println("banner ad")
            let options = HZBannerAdOptions()
            HZBannerAd.placeBannerInView(self.view, position: HZBannerPosition.Bottom, options:options, success: {(banner) in
                }, failure: {(error) in
                    println("Error is \(error)")
            })
            break
        case 1:
            println("interstitial ad")
            HZInterstitialAd.fetch()
            break
        case 2:
            println("rewarded video ad")
            HZIncentivizedAd.fetch();
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        HZInterstitialAd.setDelegate(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: HZAdsDelegate{
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didShowAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been displayed.
        println("didShowAdWithTag", tag);
        stopTimer()
    }
    
    func didFailToShowAdWithTag(tag: String!, andError error: NSError!) {
        // Sent when you call `showAd`, but there isn't an ad to be shown.
        // Includes an NSError object describing the reason why.
        println("didFailToShowAdWithTag", tag);
    }
    
    func didClickAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been clicked.
        println("didClickAdWithTag", tag);
    }
    
    func didHideAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been removed from view.
        println("didHideAdWithTag", tag);
        startTimer()
    }
    
    func didReceiveAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been loaded and is ready to be displayed.
        println("didReceiveAdWithTag", tag);
        if HZInterstitialAd.isAvailable() {
            println("HZInterstitialAd.isAvailable")
            HZInterstitialAd.showForTag("default", completion: { (Bool, NSError) -> Void in
                println("HZInterstitialAd.completion")
                self.resetTimer()
            })
        }
    }
    
    func didFailToReceiveAdWithTag(tag: String!) {
        // Sent when an interstitial ad has failed to load.
        println("didFailToReceiveAdWithTag", tag);
    }
    
    func willStartAudio() {
        // The ad about to be shown will need audio. Mute any background music.
        println("willStartAudio");
    }
    
    func didFinishAudio() {
        // The ad being shown no longer needs audio.
        // Any background music can be resumed.
        println("didFinishAudio");
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
