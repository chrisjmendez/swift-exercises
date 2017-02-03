//
//  ViewController.swift
//  flicker
//
//  Created by Tommy Trojan on 2/1/17.
//  Copyright © 2017 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:Timer = Timer()
    var counter = 0.2
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myButton: UIButton!

    @IBAction func onTap(_ sender: Any) {
        print("onTap")
        startTimer()
        blinkingStart()
    }
    
    func blinkingStart(){
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [
            .curveEaseInOut,
            .repeat,
            .autoreverse,
            .allowUserInteraction
            ],
            animations: {() -> Void in
                self.myView.alpha = 0.0
        }, completion: {(_ finished: Bool) -> Void in
            print("animation compelted")
        })
    }
    
    func blinkingStop(){
        UIView.animate(withDuration: 0.12, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {() -> Void in
            self.myView.alpha = 1
        }, completion: {(_ finished: Bool) -> Void in
            // Do nothing
        })
        myView.layer.removeAllAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController {
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counterUpdater), userInfo: nil, repeats: true)
    }
    func stopTimer(){
        timer.invalidate()
        blinkingStop()
    }
    
    func resetTimer() {
        timer.invalidate()
        startTimer()
    }
    
    func counterUpdater(){
        counter -= counter
        print("counterUpdater", counter)
        if( counter == 0 ){
            stopTimer()
        }
    }
}
