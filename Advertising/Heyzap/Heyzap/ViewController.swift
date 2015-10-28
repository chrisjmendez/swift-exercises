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
        print("counterUpdater")
        countdownTxt.text = String(counter--)
        if( counter == 0 ){
            selectAD()
            resetTimer()
        }
    }
    
    //I'm only picking 1 banner ad for now
    func selectAD(){
        let randomNumber = Int.random(0...2)

        switch(randomNumber){
        case 0:
            print("banner ad")
            let options = HZBannerAdOptions()
            HZBannerAd.placeBannerInView(self.view, position: HZBannerPosition.Bottom, options:options, success: {
                (banner) in
                }, failure: {
                    (error) in print("Error is \(error)")
                }
            )
            break
        case 1:
            print("interstitial ad")
            
            HZInterstitialAd.show()
            break
        case 2:
            print("rewarded video ad")
            // As early as possible, and after showing a rewarded video, call fetch
            HZIncentivizedAd.fetch();
            // Later, such as after a level is completed
            HZIncentivizedAd.show()
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
        print("didShowAdWithTag", tag);
        stopTimer()
    }
    
    func didFailToShowAdWithTag(tag: String!, andError error: NSError!) {
        // Sent when you call `showAd`, but there isn't an ad to be shown.
        // Includes an NSError object describing the reason why.
        print("didFailToShowAdWithTag", tag);
    }
    
    func didClickAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been clicked.
        print("didClickAdWithTag", tag);
    }
    
    func didHideAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been removed from view.
        print("didHideAdWithTag", tag);
        startTimer()
    }
    
    func didReceiveAdWithTag(tag: String!) {
        // Sent when an interstitial ad has been loaded and is ready to be displayed.
        print("didReceiveAdWithTag", tag);
        if HZInterstitialAd.isAvailable() {
            print("HZInterstitialAd.isAvailable")
            HZInterstitialAd.showForTag("default", completion: { (Bool, NSError) -> Void in
                print("HZInterstitialAd.completion")
                self.resetTimer()
            })
        }
    }
    
    func didFailToReceiveAdWithTag(tag: String!) {
        // Sent when an interstitial ad has failed to load.
        print("didFailToReceiveAdWithTag", tag);
    }
    
    func willStartAudio() {
        // The ad about to be shown will need audio. Mute any background music.
        print("willStartAudio");
    }
    
    func didFinishAudio() {
        // The ad being shown no longer needs audio.
        // Any background music can be resumed.
        print("didFinishAudio");
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
