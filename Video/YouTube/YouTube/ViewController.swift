//
//  ViewController.swift
//  YouTube
//
//  Created by Tommy Trojan on 10/2/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController, YouTubePlayerDelegate {
    
    var videoPlayer:YouTubePlayerView?
    
    func initVideo(){
        
        let frame:CGRect = CGRect(x: 0, y: 0, width: getVideoSize()[0], height: getVideoSize()[1] )
        videoPlayer = YouTubePlayerView( frame: frame )
        
        self.view.addSubview(videoPlayer!)
    }
    
    func loadPlaylist(id:String){
        if(id != ""){
            videoPlayer?.loadPlaylistID(id)
        }
    }
    
    func loadVideo(id:String){
        if(id != ""){
            videoPlayer!.loadVideoID(id)
        }
    }
    
    func loadVideoURL(url:String){
        if(url != ""){
            videoPlayer!.loadVideoURL(NSURL(fileURLWithPath: url))
        }
    }
    
    func getVideoSize() -> Array<Int> {
        var values:Array<Int>?
        
        var width = self.view.frame.width
        var height = self.view.frame.height
        
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
        
        print( w, h )
        
        values = [w, h ]
        return values!
        
    }
    
    func playerReady(videoPlayer: YouTubePlayerView) {
        print("playerReady")
    }
    
    func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print("playerStateChanged", playerState )
    }
    
    func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        print("playerQualityChanged", playbackQuality )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initVideo()
        loadVideo("WivhDJRXCU4")
        
        self.navigationController!.navigationBar.translucent = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
    }


}

