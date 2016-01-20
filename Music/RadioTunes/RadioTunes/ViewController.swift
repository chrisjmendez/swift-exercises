//
//  ViewController.swift
//  RadioTunes
//
//  Created by Chris on 1/19/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    let stream = NSURL(string: "http://playerservices.streamtheworld.com/pls/KUSCAAC64.pls")
    var radio:YLHTTPRadio?
    var interruptedDuringPlayback = false

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var composerLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var programName: UILabel!

    @IBOutlet weak var playPauseButton: UIButton!
    @IBAction func onPlayPause(sender: AnyObject) {
        if radio?.isPlaying() == false {
            radio?.play()
        }
        else if radio?.isPlaying() == true {
            radio?.pause()
        }
    }
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBAction func onVolumeSlider(sender: AnyObject) {
        let slider = sender as? UISlider
        //print("onVolumeSlider:", slider?.value)
        radio?.setVolume((slider?.value)!)
    }

    func updatePlayPause(title:String, enabled:Bool){
        playPauseButton.titleLabel?.text = ""
        playPauseButton.titleLabel?.text = title
        playPauseButton.enabled = enabled
    }

    func updateTitle(title:String){
        titleLabel.text = title
        //TODO - Split the text using a string parser then updateComposer
    }
    
    func updateComposer(composer:String){
        composerLabel.text = composer
    }
    
    func updateName(name:String){
        programName.text = name
    }
    
    func updateGenre(genre:String){
        genreLabel.text = genre
    }
    
    func onLoad(){
        print("onLoad \(stream!)")
        radio = YLHTTPRadio.init(URL: stream!)
        radio?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
        
        //Tracks the headphone stuff
        YLAudioSession.sharedInstance().addDelegate(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Not sure what this does
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().endReceivingRemoteControlEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

}

extension ViewController:YLAudioSessionDelegate {
    func beginInterruption() {
        if radio == nil {
            print("Begin Interruption")
            return
        }
        
        if radio?.isPlaying() == true {
            print("Interrupted During Playback")
            interruptedDuringPlayback = true
            radio?.pause()
        }
    }
    
    func endInterruptionWithFlags(flags: UInt) {
        if radio == nil {
            return
        }
        
        if radio?.isPaused() == true {
            if interruptedDuringPlayback == true {
                radio?.play()
            }
        }
        interruptedDuringPlayback = false
    }
    
    func headphoneUnplugged() {
        if radio == nil {
            return
        }
        
        if radio?.isPlaying() == true {
            radio?.pause()
        }
    }
}

extension ViewController:YLRadioDelegate{
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        if event?.type == UIEventType.RemoteControl {
            print("remoteControlReceivedWithEvent", event?.type)
            if event?.subtype == UIEventSubtype.RemoteControlTogglePlayPause {
                
            }
            else if event?.subtype == UIEventSubtype.RemoteControlPause {
                
            }
            else if event?.subtype == UIEventSubtype.RemoteControlPlay {
                
            }
            else {
                print( event?.subtype )
            }
        }
    }
    
    func radioStateChanged(radio: YLRadio!) {
        let state = radio.radioState
        //print("radioStateChanged:", state)
        if state == kRadioStateConnecting {
            print("Status: Connecting")
            updatePlayPause("Pause", enabled: false)
        }
        else if state == kRadioStateBuffering {
            print("Radio is Buffering")
            updatePlayPause("Pause", enabled: true)
        }
        else if state == kRadioStatePlaying {
            print("Radio is Playing")
            updatePlayPause("Pause", enabled: true)
        }
        else if state == kRadioStateStopped {
            print("Radio is Stopped")
            updatePlayPause("Play", enabled: true)
        }
        else if state == kRadioStateError {
            let error = radio.radioError
            updatePlayPause("Play", enabled: true)
            print( "Radio Error \(error)")
            switch(error){
            case kRadioErrorAudioQueueBufferCreate:
                print("Audio buffers could not be created.")
                break
            case kRadioErrorAudioQueueBufferCreate:
                print("Audio queue could not be created.")
                break
            case kRadioErrorAudioQueueEnqueue:
                print("Audio queue enqueue failed.")
                break
            case kRadioErrorAudioQueueStart:
                print("Audio queue could not be started.")
                break
            case kRadioErrorFileStreamGetProperty:
                print("File stream get property failed.")
                break
            case kRadioErrorFileStreamOpen:
                print("File stream could not be opened.")
                break
            case kRadioErrorPlaylistParsing:
                print("Playlist could not be parsed.")
                break
            case kRadioErrorDecoding:
                print("Audio decoding error.")
                break
            case kRadioErrorHostNotReachable:
                print("Radio host not reachable.")
                break
            case kRadioErrorNetworkError:
                print("Network connection error.")
                break
            case kRadioErrorUnsupportedStreamFormat:
                print("Unsupported stream format.")
                break
            default:
                print("Unknown Error \(error)")
                break
            }
        }
    }
    
    func radioMetadataReady(radio: YLRadio!) {
        print("radioMetadataReady:", radio)
        let title = radio.radioTitle
        let name  = radio.radioName
        let genre = radio.radioGenre
        let url   = radio.radioUrl
        
        if title != nil {
            print("Radio Metadata Title:", title)
            updateTitle(title)
        }
        
        if name != nil {
            print("Radio Metadata Name :", name)
            updateName(name)
        }
        if genre != nil {
            print("Radio Metadata Genre :", genre)
            updateGenre(genre)
        }
        if url != nil {
            //print("Radio Metadata URL :", url)
        }
    }
}