//
//  ViewController.swift
//  MyAsync
//
//  Created by Chris Mendez on 2/27/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import Async
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    let CUSTOMER_NAMES = "http://codepen.io/chrisaiv/pen/NNWvBO.js"
    
    //MARK: - Outlets
    @IBOutlet weak var nextBuyer: UILabel!
    
    @IBOutlet weak var currentBuyer: UILabel!
    
    @IBOutlet weak var tapeRoll: UITextView!
    
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBAction func onReset(sender: AnyObject) {
        clearLabels()
    }
    
    @IBOutlet weak var buyBtn: UIButton!
    @IBAction func onBuy(sender: AnyObject) {
        buyTicket()
        disableBuy()
    }
    
    var customers:[String] = []
    var currentIdx:Int = 0
    
    //MARK: - GUI
    func disableBuy(){
        buyBtn.enabled = false
    }
    
    func enableBuy(){
        buyBtn.enabled = true
    }
    
    func clearLabels(){
        updateTapeRoll("---")
        updateNextBuyer("---")
        updateCurrentBuyer("---")
    }
    
    func updateTapeRoll(string:String){
        let oldMessage:String = tapeRoll.text
        let newMessage:String = "\(string)\n"
        
        tapeRoll.text = oldMessage + newMessage
    }
    
    func updateCurrentBuyer(string:String){
        print("updateCurrentBuyer: ", string)
        currentBuyer.text = string
    }
    
    func updateNextBuyer(string:String){
        print("updateNextBuyer:", string)
        nextBuyer.text = string
    }
    
    //Get JSON data
    func queueCustomers(){
        Alamofire.request(.GET, CUSTOMER_NAMES).responseJSON { (response) -> Void in
            if response.result.isFailure {
                print("Error")
            } else {
                let data = JSON(response.result.value!)
                //Append each JSON object item into an NSArray
                for(index, value):(String, JSON) in data {
                    let name = value["author"].string!
                    self.customers.append( name )
                }
                self.updateTapeRoll("Customer Data Loaded")
            }
        }
    }
    
    //MARK: - Customer buys and pays for ticket
    func buyTicket(){
        
        print("Customer:", currentIdx ,"of:", customers.count)
        
        if currentIdx >= customers.count{
            print("z")
            clearLabels()
            disableBuy()
            updateCurrentBuyer("No More Customer")
        } else {
            let thisCustomer = self.customers[self.currentIdx]
            let nextCustomer = self.customers[self.currentIdx + 1]

            var timeFrame:Double = 0.0

            let parallelQueue = dispatch_queue_create("SerialQueue", DISPATCH_QUEUE_CONCURRENT)
            
            Async.main {
                print("a")
                //Indicate who is currently buying and who is coming up next
                self.updateCurrentBuyer("Current: \(thisCustomer)")
                self.updateNextBuyer("Next: \(nextCustomer)")
            }.background {
                print("b0")

                //Retreive data from 3 different processes and wait for it to happen
                let group = AsyncGroup()
                    group.background {
                        print("b1", "Waiting to secure ticket")
                        timeFrame = Simulator.sharedInstance.runSimulatorWithMinTime(1, maxTime: 5)
                    }
                    group.background {
                        print("b2", "Securing payment tocken")
                        timeFrame = Simulator.sharedInstance.runSimulatorWithMinTime(1, maxTime: 5)
                    }
                    group.background {
                        print("b3", "Submitting payment")
                        self.submitPayment(thisCustomer)
                    }
                    group.wait()
            }.main {
                print("d0", "A Processes were completed")
                self.updateTapeRoll("\(thisCustomer) bought tickets in \(timeFrame).")
                print("d1")
                self.currentIdx++
                self.enableBuy()
            }
        }
    }
    
    func submitPayment(customerName:String){
        print("c0")
        var duration:Double = 0.0
        let group = AsyncGroup()

        group.background {
            print("c1")
            duration = Simulator.sharedInstance.runSimulatorWithMinTime(2, maxTime: 5)
            print("Payment sucess in \(duration)")
        }
        group.main {
            print("c2")
            print("Payment completed")
            self.updateTapeRoll("\(customerName) paid in \(duration)")
        }
        group.wait()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearLabels()
    }
    
    override func viewDidAppear(animated: Bool) {
        queueCustomers()
    }
}
