//
//  ViewController.swift
//  Countdown
//
//  Created by tommy trojan on 5/16/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer:NSTimer = NSTimer()
    var counter:UInt = 0
    
    @IBOutlet weak var counterLbl: UILabel!
    
    @IBAction func start(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("counterUpdater"), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func clear(sender: AnyObject) {
        timer.invalidate()
        counter = 0
        counterLbl.text = String(counter)
    }
    
    func counterUpdater(){
        counterLbl.text = String(counter++)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLbl.text = String(counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

