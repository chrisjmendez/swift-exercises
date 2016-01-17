//
//  ViewController.swift
//  YouTubeParser
//
//  Created by Chris on 1/16/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    let testURL = NSURL(string: "https://www.youtube.com/watch?v=4niz8TfY794")!

    var player:AVPlayer?
    
    @IBAction func onPause(sender: AnyObject) {
        let button = sender as! UIButton
        let currentState = button.titleLabel?.text

        if currentState == "Pause" {
            button.setTitle("Play", forState: UIControlState.Normal)
            player?.pause()
        }
        if currentState == "Play" {
            button.setTitle("Pause", forState: UIControlState.Normal)
            player?.play()
        }
        
    }
    
    func onLoad(){
        Youtube.h264videosWithYoutubeURL(testURL) { (videoInfo, error) -> Void in
            if error != nil {
                print("Error: \(error)")
            }
            if let videoURLString = videoInfo?["url"] as? String,
                videoTitle = videoInfo?["title"] as? String {
                    print("\(videoTitle)")
                    
                    print("\(videoURLString)")
                    self.loadVideo(videoTitle, url: videoURLString)
            }
        }
    }
    
    func loadVideo(title:String, url:String){
        let playerURL = NSURL(string: url)!
        
        player = AVPlayer(URL: playerURL)
        player!.rate = 1
        player?.addObserver(self, forKeyPath: "status", options:NSKeyValueObservingOptions(), context: nil)
        player?.addObserver(self, forKeyPath: "playbackBufferEmpty", options:NSKeyValueObservingOptions(), context: nil)
        player?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options:NSKeyValueObservingOptions(), context: nil)
        player?.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions(), context: nil)
        
        let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = CGRect(x: 0, y: 0, width: getVideoSize()[0], height: getVideoSize()[1] )
        
        view.layer.addSublayer(playerLayer)
    }
    
    //Keep tabs on the things that are playing
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "status" {
            print("Change at keyPath = \(keyPath) for \(object)")
        }
        
        if keyPath == "playbackBufferEmpty" {
            print("No internet connection!", "Mixmatic requires an internet connection to continue streaming.")
            print("Change at keyPath = \(keyPath) for \(object)")
        }
        
        if keyPath == "playbackLikelyToKeepUp" {
            print("Change at keyPath = \(keyPath) for \(object)")
        }
        
        if keyPath == "loadedTimeRanges" {
            print("Change at keyPath = \(keyPath) for \(object)")
        }
    }
    
    private func deallocObservers(player: AVPlayer) {
        player.removeObserver(self, forKeyPath: "status")
        player.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        player.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        player.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }
    
    func getVideoSize() -> Array<Int> {
        var values:Array<Int>?
        
        let width  = view.frame.width
        let height = view.frame.height
        
        var w = 0
        var h = 0
        
        //1080p: 1920x1080
        if( width >= 1920 && height >= 1080 ){
            w = 1920
            h = 1080
        }
        //720p: 1280x720
        else if( width >= 1280 && height >= 720 ) {
            w = 1280
            h = 720
        }
        //480p: 854x480
        else if( width >= 854 && height >=  480 ){
            w = 854
            h = 480
        }
        //360p: 640x360
        else if( width >= 640 && height >=  360 ){
            w = 640
            h = 360
        }
        //240p: 426x240
        else{
            w = 426
            h = 240
        }
        
        //print( w, h )
        
        values = [w, h ]
        return values!
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

