//
//  ViewController.swift
//  AudioPlayer
//
//  Created by tommy trojan on 5/18/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let songs:[(path: String, format: String)] = [
        (path: "24_Ghosts_III_320kb", format: "mp3"),
        (path: "Mazurka in A Minor, Op. 13", format: "mp3")
        ]
    
    var currentIndex:Int = 0
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var volumeControl: UISlider!
    
    @IBAction func onPlayClicked(sender: AnyObject) {
        if let player = audioPlayer {
            player.play()
        }
    }
    
    @IBAction func onStopClicked(sender: AnyObject) {
        if let player = audioPlayer {
            player.stop()
        }
    }
    
    @IBAction func onVolumeDragHandler(sender: AnyObject) {
        if audioPlayer != nil {
            audioPlayer?.volume = volumeControl.value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Pick a song
        currentIndex = Int.random(0...(songs.count-1))
        
        var err:NSError?
        
        let track = NSBundle.mainBundle().pathForResource( songs[currentIndex].path, ofType: songs[currentIndex].format)!
        
        let u = NSURL.fileURLWithPath(track)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: u)
        } catch let error as NSError {
            err = error
            audioPlayer = nil
        }
        
        if let error = err {
            print("audioPlayer Err: \(error.localizedDescription)")
        } else {
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying")
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("audioPlayerDecodeErrorDidOccur")
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        print("audioPlayerBeginInterruption")
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer) {
        print("audioPlayerEndInterruption")
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
