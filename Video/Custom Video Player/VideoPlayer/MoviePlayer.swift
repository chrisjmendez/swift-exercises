//
//  MoviePlayer.swift
//  VideoPlayer
//
//  Created by Ankit Shah on 10/09/15.
//  Copyright (c) 2015 Ankit Shah. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol MoviePlayerDelegate: class {
    optional func updateSeekTime(seekTime: CGFloat)
    optional func playButtonPressed()
    optional func resizeButtonPressed()
}

class MoviePlayer: UIView {
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var fullScreenButton: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var filledView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var sliderCircle: UIImageView!
    var view: UIView!
    
    var nibName: String = "MoviePlayer"
    var videoPlaying: Bool = false
    var sliderMinX: CGFloat!
    var sliderMaxX: CGFloat!
    var seekTime: CGFloat!
    var totalTime: Double!
    var stopUpdateView: Bool = false
    var videoIsFullscreen: Bool = false
    var updateBlock: (CMTime -> Void)!
    var videoPlayer: AVPlayer!
    var videoPlayerLayer: AVPlayerLayer!
    var videoURL: String!
    var sliderCircleHeight: CGFloat!
    var originalFrame: CGRect!
    
    private let kSliderCircleExpandedHeight: CGFloat = 24.0
    
    weak var delegate: MoviePlayerDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
        
        originalFrame = frame
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("progressBarTapped:"))
        overlayView.addGestureRecognizer(tapGesture)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("moveSlider:"))
        panGestureRecognizer.maximumNumberOfTouches = 1
        sliderView.addGestureRecognizer(panGestureRecognizer)
        
        let toggleControlView = UITapGestureRecognizer(target: self, action: Selector("toggleControlView"))
        self.addGestureRecognizer(toggleControlView)
        
        sliderMinX = emptyView.frame.origin.x - sliderView.frame.width/2
        sliderMaxX = sliderMinX + emptyView.frame.width
        
        sliderCircleHeight = sliderCircle.frame.height
        
        updateBlock = { (time: CMTime) -> Void in
            if self.videoPlayer != nil {
                if self.totalTime == 0.0 {
                    self.totalTime = CMTimeGetSeconds(self.videoPlayer.currentItem!.asset.duration)
                    if self.totalTime == 0.0 {
                        return
                    }
                    let totalSeconds = Int(self.totalTime)
                    self.totalTimeLabel.text = String(format: "%02d:%02d", totalSeconds/60, totalSeconds%60)
                }
                let currentTimeLabel = CMTimeGetSeconds(time)
                if !self.stopUpdateView {
                    self.sliderView.frame.origin.x = self.sliderMinX + (self.emptyView.frame.width * CGFloat(currentTimeLabel / self.totalTime))
                    self.filledView.frame.size.width = self.emptyView.frame.width * CGFloat(currentTimeLabel / self.totalTime)
                }
                let seconds = Int(CMTimeGetSeconds(time))
                self.currentTimeLabel.text = String(format: "%02d:%02d", seconds/60, seconds%60)
                if currentTimeLabel == self.totalTime {
                    self.playbackFinished()
                }
            }
        }
        
        self.bringSubviewToFront(controlView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class func layerClass() -> AnyClass {
        return AVPlayerLayer.self
    }
    
    //MARK: Init from xib
    func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    //MARK: - Callback methods
    @IBAction func playButtonPressed(sender: AnyObject) {
        delegate?.playButtonPressed?()
        if videoPlaying {
            videoPlayer?.pause()
            
            videoPlaying = false
            playButton.setImage(UIImage(named: "playVideo"), forState: UIControlState.Normal)
        }
        else {
            if videoPlayer.error != nil {
                print(videoPlayer.error)
                return
            }
            videoPlayer.play()
            
            videoPlaying = true
            playButton.setImage(UIImage(named: "pauseVideo"), forState: UIControlState.Normal)
        }
    }

    @IBAction func fullScreenPressed(sender: AnyObject) {
        delegate?.resizeButtonPressed?()
//        if videoIsFullscreen {
//            videoIsFullscreen = false
//            UIView.animateWithDuration(0.3,
//                animations: { () -> Void in
//                    self.frame = self.originalFrame
//                },
//                completion: { (completed: Bool) -> Void in
//                    if completed {
//                        self.fullScreenButton.setImage(UIImage(named: "fullScreen"), forState: UIControlState.Normal)
//                    }
//            })
//        }
//        else {
//            videoIsFullscreen = true
//            UIView.animateWithDuration(0.3,
//                animations: { () -> Void in
//                    self.frame = self.window!.bounds
//                },
//                completion: { (completed: Bool) -> Void in
//                    if completed {
//                        self.fullScreenButton.setImage(UIImage(named: "exitFullScreen"), forState: UIControlState.Normal)
//                    }
//                })
//        }
    }
    
    func moveSlider(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            self.stopUpdateView = true
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.sliderCircle.frame = CGRectMake(self.sliderView.frame.width/2 - self.kSliderCircleExpandedHeight/2, self.sliderView.frame.height/2 - self.kSliderCircleExpandedHeight/2, self.kSliderCircleExpandedHeight, self.kSliderCircleExpandedHeight)
            })
        }
        else if recognizer.state == UIGestureRecognizerState.Ended {
            seekPlayer(sliderView.frame.origin.x - sliderMinX)
            UIView.animateWithDuration(0.2,
                animations: { () -> Void in
                    self.sliderCircle.frame = CGRectMake(self.sliderView.frame.height/2 - self.sliderCircleHeight/2, self.sliderView.frame.height/2 - self.sliderCircleHeight/2, self.sliderCircleHeight, self.sliderCircleHeight)
                },
                completion: { (completed: Bool) -> Void in
                    if completed {
                        self.stopUpdateView = false
                    }
            })
        }
        else {
            let newX = recognizer.locationInView(self).x - sliderView.frame.height/2
            updateSlider(newX)
        }
    }
    
    func progressBarTapped(sender: UITapGestureRecognizer) {
        let newX = sender.locationInView(self).x - sliderView.frame.height/2
        updateSlider(newX)
        seekPlayer(sliderView.frame.origin.x - sliderMinX)
    }
    
    func toggleControlView() {
        controlView.hidden = !controlView.hidden
    }
    
    //MARK: - Helper methods
    func setVideoUrl(url: String) {
        totalTime = 0.0
        videoURL = url
        videoPlayer = AVPlayer(URL: NSURL(string: videoURL)!)
        videoPlayer.addPeriodicTimeObserverForInterval(CMTimeMake(1, 10),
            queue: dispatch_get_main_queue(),
            usingBlock: updateBlock)
        (self.layer as! AVPlayerLayer).player = videoPlayer
        
    }
    
    func updateSlider(newX: CGFloat) {
        if newX >= sliderMaxX {
            sliderView.frame.origin.x = sliderMaxX
            filledView.frame.size.width = sliderMaxX - sliderMinX
        }
        else if newX <= sliderMinX {
            sliderView.frame.origin.x = sliderMinX
            filledView.frame.size.width = 0
        }
        else {
            sliderView.frame.origin.x = newX
            filledView.frame.size.width = newX - sliderMinX
        }
    }
    
    func seekPlayer(position: CGFloat) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.videoPlayer != nil && self.videoPlayer.status == AVPlayerStatus.ReadyToPlay && self.videoPlayer.currentItem!.status == AVPlayerItemStatus.ReadyToPlay {
                let seconds = CGFloat(self.totalTime) * position / self.emptyView.frame.width
                let seekTime = CMTimeMakeWithSeconds(Double(seconds), 600)
                self.videoPlayer.seekToTime(seekTime)
            }
        })
    }
    
    func pause() {
        if videoPlaying {
            videoPlayer?.pause()
            
            videoPlaying = false
            playButton.setImage(UIImage(named: "playVideo"), forState: UIControlState.Normal)
        }
    }
    
    func playbackFinished() {
        videoPlaying = false
        updateSlider(sliderMinX)
        seekPlayer(0)
        playButton.setImage(UIImage(named: "playVideo"), forState: UIControlState.Normal)
        currentTimeLabel.text = "00:00"
    }
}
