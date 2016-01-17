//
//  ViewController.swift
//  YouTubeCopycat
//
//  Created by Chris on 1/16/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let playlist = "http://content.uplynk.com/468ba4d137a44f7dab3ad028915d6276.m3u8"
    var videoPlayer:KSVideoPlayerView?
    
    func onLoad(){
        let url   = NSURL(string: playlist)
        let newFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        videoPlayer = KSVideoPlayerView(frame: newFrame, contentURL: url!)
        videoPlayer?.tintColor = UIColor.redColor()
        videoPlayer?.play()
        
        view.addSubview(videoPlayer!)
    }
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {

        UIView.animateWithDuration(duration, animations: { () -> Void in
            print("animating")
            }) { (finished) -> Void in
                if finished == true{
                    let newFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                    self.videoPlayer?.frame = newFrame
                }
        }
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
