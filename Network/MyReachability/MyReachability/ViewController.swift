//
//  ViewController.swift
//  MyReachability
//
//  Created by Chris on 1/19/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer



/**
 `AudioPlayerState` defines 4 state an `AudioPlayer` instance can be in.
 
 - `Buffering`:            The player is buffering data before playing them.
 - `Playing`:              The player is playing.
 - `Paused`:               The player is paused.
 - `Stopped`:              The player is stopped.
 - `WaitingForConnection`: The player is waiting for internet connection.
 - `Failed`:               An error occured. It contains AVPlayer's error if any.
 */
public enum AudioPlayerState {
    case Buffering
    case Playing
    case Paused
    case Stopped
    case WaitingForConnection
    case Failed(NSError?)
}

extension AudioPlayerState: Equatable { }

public func ==(lhs: AudioPlayerState, rhs: AudioPlayerState) -> Bool {
    switch (lhs, rhs) {
    case (.Buffering, .Buffering):
        return true
    case (.Playing, .Playing):
        return true
    case (.Paused, .Paused):
        return true
    case (.Stopped, .Stopped):
        return true
    case (.WaitingForConnection, .WaitingForConnection):
        return true
    case (.Failed(let e1), .Failed(let e2)):
        return e1 == e2
    default:
        return false
    }
}


class ViewController: UIViewController {
    
    /// The date of the connection loss
    private var connectionLossDate: NSDate?
    
    
    
    @IBOutlet weak var networkStatus: UILabel!
    @IBOutlet weak var hostNameLabel: UILabel!
    
    var reachability: Reachability?
    
    func onLoad(){
        // Start reachability without a hostname intially
        setupReachability(hostName: nil, useClosures: false)
        
        startNotifier()
        
        // After 5 seconds, stop and re-start reachability, this time using a hostname
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(5) * NSEC_PER_SEC))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.stopNotifier()
            self.setupReachability(hostName: "google.com", useClosures: true)
            self.startNotifier()
            
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(5) * NSEC_PER_SEC))
            dispatch_after(dispatchTime, dispatch_get_main_queue()) {
                self.stopNotifier()
                self.setupReachability(hostName: "invalidhost", useClosures: true)
                self.startNotifier()            }
            
        }
    }
    
    func setupReachability(hostName hostName: String?, useClosures: Bool) {
        hostNameLabel.text = hostName != nil ? hostName : "No host name"
        
        print("--- set up with host name: \(hostNameLabel.text!)")
        
        do {
            let reachability = try hostName == nil ? Reachability.reachabilityForInternetConnection() : Reachability(hostname: hostName!)
            self.reachability = reachability
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
            networkStatus.textColor = UIColor.redColor()
            networkStatus.text = "Unable to create\nReachability with address:\n\(address)"
            return
        } catch {}
        
        if (useClosures) {
            reachability?.whenReachable = { reachability in
                dispatch_async(dispatch_get_main_queue()) {
                    self.updateLabelColourWhenReachable(reachability)
                }
            }
            reachability?.whenUnreachable = { reachability in
                dispatch_async(dispatch_get_main_queue()) {
                    self.updateLabelColourWhenNotReachable(reachability)
                }
            }
        } else {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        }
    }
    
    func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            networkStatus.textColor = UIColor.redColor()
            networkStatus.text = "Unable to start\nnotifier"
            return
        }
    }
    
    func stopNotifier() {
        print("--- stop notifier")
        reachability?.stopNotifier()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        reachability = nil
    }
    
    func updateLabelColourWhenReachable(reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
        if reachability.isReachableViaWiFi() {
            self.networkStatus.textColor = UIColor.greenColor()
        } else {
            self.networkStatus.textColor = UIColor.blueColor()
        }
        
        self.networkStatus.text = reachability.currentReachabilityString
    }
    
    func updateLabelColourWhenNotReachable(reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
        
        self.networkStatus.textColor = UIColor.redColor()
        
        self.networkStatus.text = reachability.currentReachabilityString
    }
    
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }
    
    deinit {
        stopNotifier()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

