//
//  ViewController.swift
//  MediaPlayer
//
//  Created by Tommy Trojan on 10/2/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

import AVFoundation
import AVKit

class ViewController: UIViewController {

    let videoFile = ["file": "videos/fire_848x480", "type": "mp4"]
    var player:AVPlayer?
    
    func loadVideo() {
        //Since we're using concurrency, we'll be using 'self' a lot
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            let path = NSBundle.mainBundle().pathForResource( self.videoFile["file"], ofType: self.videoFile["type"] )!
            
            let playerURL = NSURL(fileURLWithPath: path)
            
            self.player = AVPlayer(URL: playerURL)
            self.player!.rate = 1
            self.player!.play()
            
            let playerLayer = AVPlayerLayer(player: self.player)
                //The AVPlayerLayer neeeds to be added to the video player's layer and resized
                playerLayer.frame = CGRect(x: 0, y: 0, width: 848, height: 800)

            
            self.view.layer.addSublayer(playerLayer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadVideo()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

