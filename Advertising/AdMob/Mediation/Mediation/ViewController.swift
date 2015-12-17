//
//  ViewController.swift
//  Mediation
//
//  Created by Tommy Trojan on 10/29/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    let TEST_DEVICE = "181024612"
    let AD_UNIT_ID = "ca-app-pub-1141743128060240/8575652810"
    
    enum GameState: NSInteger{
        case NotStarted
        case Playing
        case Paused
        case Ended
    }
    
    var timer:NSTimer?
    
    /// The game counter.
    var counter = 3
    
    /// The interstitial ad.
    var interstitial: GADInterstitial?
    
    /// The state of the game.
    var gameState = GameState.NotStarted
    
    /// The date that the timer was paused.
    var pauseDate: NSDate?
    
    /// The last fire date before a pause.
    var previousFireDate: NSDate?
    
    // ///////////////////////////////////
    // Advertising
    // ///////////////////////////////////
    private func loadInterstitial(){
        interstitial = GADInterstitial(adUnitID: AD_UNIT_ID)
        interstitial!.delegate = self
        
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADInterstitial automatically returns test ads when running on a
        // simulator.
        let request = GADRequest()
        //request.testDevices = [TEST_DEVICE]
        request.testDevices = [kGADSimulatorID];
        
        interstitial!.loadRequest(request)
    }
    
    func showInterstitial(){
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .LongStyle)
        print("showInterstitial \(timestamp)")
        if (interstitial!.isReady) {
            interstitial!.presentFromRootViewController(self)
        }
    }

    
    // ///////////////////////////////////
    // Game State
    // ///////////////////////////////////
    func pauseGame(){
        if (gameState != .Playing) {
            return
        }
        gameState = .Paused
        
        // Record the relevant pause times.
        pauseDate = NSDate()
        previousFireDate = timer!.fireDate
        
        // Prevent the timer from firing while app is in background.
        timer!.fireDate = NSDate.distantFuture() 
    }
    
    func resumeGame(){
        if (gameState != .Paused) {
            return
        }
        gameState = .Playing
        
        // Calculate amount of time the app was paused.
        let pauseTime = pauseDate!.timeIntervalSinceNow * -1
        
        // Set the timer to start firing again.
        timer!.fireDate = previousFireDate!.dateByAddingTimeInterval(pauseTime)
    }
    
    func decrementCounter(timer: NSTimer) {
        counter--
        if (counter > 0) {
            //gameText.text = String(counter)
        } else {
            endGame()
        }
    }
    
    func startNewGame(){
        gameState = .Playing
        counter = 3
//        playAgainButton.hidden = true
        loadInterstitial()
//        gameText.text = String(counter)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"decrementCounter:", userInfo: nil, repeats: true)
    }
    
    func endGame(){
        gameState = .Ended
//        gameText.text = "Game over!"
//        playAgainButton.hidden = false
        timer!.invalidate()
        timer = nil
        
        if ((interstitial?.isReady) != nil) {
            interstitial!.presentFromRootViewController(self);
        }
    }
    
    func playAgain(){
        if (interstitial!.isReady) {
            interstitial!.presentFromRootViewController(self)
        } else {
            UIAlertController(title: "Interstitial not ready", message: "The interstitial didn't finish loading or failed to load", preferredStyle: .Alert)
        }
    }

    
    // ///////////////////////////////////
    // On Load
    // ///////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Load the AD
        loadInterstitial()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}


extension ViewController: GADInterstitialDelegate{
    func interstitialDidDismissScreen(ad: GADInterstitial!) {
        print("User closed AD")
        startNewGame()
    }
    
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        print("Ad was received")
        showInterstitial()
        
    }
    
    func interstitialWillLeaveApplication(ad: GADInterstitial!) {
        print("User will leave app")
    }
    
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        print("Ad is being presented")
    }
}
