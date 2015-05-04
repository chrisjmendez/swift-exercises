//
//  ViewController.swift
//  Concurrency
//
//  Created by tommy trojan on 4/11/15.
//  Copyright (c) 2015 Skyground Media Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nextBuyerLbl: UILabel!
    
    @IBOutlet weak var currentBuyerLbl: UILabel!
    
    @IBOutlet weak var tapeRollLbl: UITextView!
    
    
    @IBOutlet weak var onAlphaSlider: UISlider!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    let customers:Array<String> = ["Audrey", "B", "C", "D", "E"]

    var currentIdx:Int = 0
    
    var serial:dispatch_queue_t = dispatch_queue_create("com.test.serial", DISPATCH_QUEUE_SERIAL)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        clearLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        buyTicket()
    }
    
    @IBAction func onAlphaChanged(sender: AnyObject) {

    }
    
    @IBAction func onResetClicked(sender: AnyObject) {

    }

    @IBAction func onBuyClicked(sender: AnyObject) {
        buyTicket()
    }
    
    func clearLabels(){
        updateLabels( "currentBuyerLbl", message: "")
        updateLabels( "tapeRollLbl", message: "")
        updateLabels( "nextBuyerLbl", message: "")
    }
    
    //Serial task
    func buyTicket(){
        //Increment the index
        currentIdx++
        if(currentIdx == customers.count ){
            //Turn off the BUY button
            buyBtn.enabled = false
            
            clearLabels()
            
            updateLabels( "currentBuyerLbl", message: "No more customers.")
        }else{
            //Switch to new customer
            let customerName:String = customers[currentIdx]
            
            dispatch_async(serial, {
                //Run simulator to resemble an HTTP request
                let num:Double = Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 5)
                //You cannot update the UIX from a background thread so you call this data back up the main UIX.
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //Update the text label with the new async data
                    self.updateLabels("currentBuyerLbl", message: "Current: " + self.customers[self.currentIdx])
                    
                    self.updateLabels("tapeRollLbl", message: "\(customerName) bought tickets in \(num).")
                    
                    var nextIdx:Int = self.currentIdx + 1
                    self.updateLabels( "nextBuyerLbl", message: "Next:self. " + self.customers[nextIdx])
                })
            })
            //Customer Will Now Pay
            submitPayment(customerName)
        }
    }
    
    //Parallel task
    func submitPayment(customerName:String){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { ()-> Void in
            //Run simulator to resemble an HTTP request
            let num:Double = Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 5)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //Update the text label with the new async data
                self.updateLabels("tapeRollLbl", message: "\(customerName) paid in \(num).")
            })
        })
    }
    
    func updateLabels(label:String, message:String){
        
        switch(label){
        case "currentBuyerLbl":
            currentBuyerLbl.text = message
            break
        case "nextBuyerLbl":
            nextBuyerLbl.text = message
            break
        case "tapeRollLbl":
            var oldMessage:String = tapeRollLbl.text
            var newMessage:String = "\(message) \n"
            
            tapeRollLbl.text = oldMessage + newMessage

            break
        default :
            break
        }
    }
}
