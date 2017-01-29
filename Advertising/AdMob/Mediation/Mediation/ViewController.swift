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
        case notStarted
        case playing
        case paused
        case ended
    }
    
    var timer:Timer?
    
    /// The game counter.
    var counter = 5
    
    /// The interstitial ad.
    var interstitial: GADInterstitial?
    
    /// The state of the game.
    var gameState = GameState.notStarted
    
    /// The date that the timer was paused.
    var pauseDate: Date?
    
    /// The last fire date before a pause.
    var previousFireDate: Date?
    
    // ///////////////////////////////////
    // Advertising
    // ///////////////////////////////////
    fileprivate func loadInterstitial(){
        interstitial = GADInterstitial(adUnitID: AD_UNIT_ID)
        interstitial!.delegate = self
        
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADInterstitial automatically returns test ads when running on a
        // simulator.
        let request = GADRequest()
        //request.testDevices = [TEST_DEVICE]
        request.testDevices = [kGADSimulatorID];
        
        interstitial!.load(request)
    }
    
    func showInterstitial(){
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .long)
        print("showInterstitial \(timestamp)")
        if (interstitial!.isReady) {
            interstitial!.present(fromRootViewController: self)
        }
    }

    
    // ///////////////////////////////////
    // Game State
    // ///////////////////////////////////
    func pauseGame(){
        if (gameState != .playing) {
            return
        }
        gameState = .paused
        
        // Record the relevant pause times.
        pauseDate = Date()
        previousFireDate = timer!.fireDate
        
        // Prevent the timer from firing while app is in background.
        timer!.fireDate = Date.distantFuture 
    }
    
    func resumeGame(){
        if (gameState != .paused) {
            return
        }
        gameState = .playing
        
        // Calculate amount of time the app was paused.
        let pauseTime = pauseDate!.timeIntervalSinceNow * -1
        
        // Set the timer to start firing again.
        timer!.fireDate = previousFireDate!.addingTimeInterval(pauseTime)
    }
    
    func decrementCounter(_ timer: Timer) {
        counter -= 1
        if (counter > 0) {
            //gameText.text = String(counter)
        } else {
            endGame()
        }
    }
    
    func startNewGame(){
        gameState = .playing
        counter = 3
//        playAgainButton.hidden = true
        loadInterstitial()
//        gameText.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(ViewController.decrementCounter(_:)), userInfo: nil, repeats: true)
    }
    
    func endGame(){
        gameState = .ended
//        gameText.text = "Game over!"
//        playAgainButton.hidden = false
        timer!.invalidate()
        timer = nil
        
        if ((interstitial?.isReady) != nil) {
            interstitial!.present(fromRootViewController: self);
        }
    }
    
    func playAgain(){
        if (interstitial!.isReady) {
            interstitial!.present(fromRootViewController: self)
        } else {
            UIAlertController(title: "Interstitial not ready", message: "The interstitial didn't finish loading or failed to load", preferredStyle: .alert)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}


extension ViewController: GADInterstitialDelegate{
    func interstitialDidDismissScreen(_ ad: GADInterstitial!) {
        print("User closed AD")
        startNewGame()
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial!) {
        print("Ad was received")
        showInterstitial()
        
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial!) {
        print("User will leave app")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial!) {
        print("Ad is being presented")
    }
}
