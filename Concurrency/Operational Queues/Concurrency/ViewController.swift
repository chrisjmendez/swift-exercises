//
//  ViewController.swift
//  Concurrency
//
//  Created by tommy trojan on 4/11/15.
//  Copyright (c) 2015 Skyground Media Inc. All rights reserved.
//
import UIKit

typealias KVOContext = UInt8

class ViewController: UIViewController {
    
    /** ** ** ** ** ** ** ** ** ** ** ** ** **
    UI Elements
    ** ** ** ** ** ** ** ** ** ** ** ** ** **/
    
    @IBOutlet weak var currentBuyerLabel: UILabel!
    
    @IBOutlet weak var nextBuyerLabel: UILabel!
    
    @IBOutlet weak var userBoughtTapeRoll: UITextView!
    
    @IBOutlet weak var userPaidTapeRoll: UITextView!

    
    @IBOutlet weak var onAlphaSlider: UISlider!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!

    @IBOutlet weak var resetBtn: UIButton!
    
    /** ** ** ** ** ** ** ** ** ** ** ** ** **
    Variables
    ** ** ** ** ** ** ** ** ** ** ** ** ** **/
    let customers:Array<String> = ["A", "B", "C", "D", "E", "F", "G"]

    var currentIdx:Int = 0
    
    var operationQueue:NSOperationQueue = NSOperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        clearLabels()
        buyNow()
    }
    
    /** ** ** ** ** ** ** ** ** ** ** ** ** **
    UI Methods
    ** ** ** ** ** ** ** ** ** ** ** ** ** **/
    @IBAction func onAlphaChanged(sender: AnyObject) {
        
    }
    
    @IBAction func onBuyClicked(sender: AnyObject) {
        buyNow()
    }
    
    @IBAction func onCancelClicked(sender: AnyObject) {
        operationQueue.cancelAllOperations()
    }

    @IBAction func onResetClicked(sender: AnyObject) {
        currentIdx = 0
    }
    
    func buyNow(){
        updateLabels( "currentBuyerLabel", message: "\(customers[currentIdx])")
        
        var remainingCustomers:Int = (customers.count - 1) - currentIdx
        updateLabels( "nextBuyerLabel", message: "\(remainingCustomers)" )
        
        if(currentIdx < customers.count - 1){
            currentIdx++
        } else {
            currentIdx = 0
        }
        buyAndPay()
    }
    
    func buyAndPay(){
        //Switch to new customer
        let customerName:String = customers[currentIdx]
        
        //1. Create an Operation from NSOperation
        var buyTicket:NSBlockOperation = NSBlockOperation.init({
            //Run simulator to resemble an HTTP request
            let num:Double = Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 5)
            //You cannot update the UIX from a background thread so you call this data back up the main UIX.
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //Update the text label with the new async data
                self.updateLabels("currentBuyerLabel", message:  self.customers[self.currentIdx])
                
                self.updateLabels("userBoughtTapeRoll", message: "\(customerName) bought tickets in \(num).")
                
                var nextIdx:Int = self.currentIdx + 1
                self.updateLabels( "nextBuyerLabel", message: self.customers[nextIdx])
            })
        })
        
        //2. Trigger a completion event
        buyTicket.completionBlock = {
            println("nsBlockOperation.completionBlock completed for \(customerName)")
        }
        
        var payTicket:NSBlockOperation = NSBlockOperation.init({
            //Run simulator to resemble an HTTP request
            let num:Double = Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 5)
            //You cannot update the UIX from a background thread so you call this data back up the main UIX.
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                println("payTicket in \(num) time")
                self.updateLabels( "userPaidTapeRoll", message: "\(customerName) paid in \(num) time")

            })
        })
        
        payTicket.addDependency( buyTicket )
        
        var MyObservationContext = KVOContext()
        
        let options = NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old
        payTicket.addObserver(self,
            forKeyPath: "isCancelled",
            options: options,
            context: &MyObservationContext )
        
        //3. Add the operations to a queue
        operationQueue.addOperation( buyTicket )
        operationQueue.addOperation( payTicket )

    }
    

    /** ** ** ** ** ** ** ** ** ** ** ** ** **
    Public Methods
    ** ** ** ** ** ** ** ** ** ** ** ** ** **/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    
    func clearLabels(){
        updateLabels( "currentBuyerLabel", message: "")
        updateLabels( "nextBuyerLabel", message: "")
        updateLabels( "userBoughtTapeRoll", message: "")
        updateLabels( "userPaidTapeRoll", message: "")
    }
    
    //Serial task
    func buyTicket(){
        //Increment the index
        currentIdx++
        if(currentIdx == customers.count ){
            //Turn off the BUY button
            buyBtn.enabled = false
            
            clearLabels()
            
            updateLabels( "currentBuyerLabel", message: "No more customers.")
        }else{
        }
    }
    
    func updateLabels(label:String, message:String){
        switch(label){
            case "currentBuyerLabel":
                currentBuyerLabel.text = message
                break
            case "nextBuyerLabel":
                nextBuyerLabel.text = message
                break
            case "userBoughtTapeRoll":
                var oldMessage:String = userBoughtTapeRoll.text
                var newMessage:String = "\(message) \n"
                
                userBoughtTapeRoll.text = oldMessage + newMessage
                break
            case "userPaidTapeRoll":
                var oldMessage:String = userPaidTapeRoll.text
                var newMessage:String = "\(message) \n"
                
                userPaidTapeRoll.text = oldMessage + newMessage

            default :
                break
        }
    }
}
