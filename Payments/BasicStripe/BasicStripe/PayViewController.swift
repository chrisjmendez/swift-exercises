//
//  PayViewController.swift
//  Stripe
//
//  Created by Tommy Trojan on 1/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    var mainTitle:String = ""
    
    @IBOutlet weak var name: TextField!
    @IBOutlet weak var number: TextField!
    @IBOutlet weak var expiration: TextField!
    @IBOutlet weak var cvv: TextField!
    
    @IBAction func onPay(sender: AnyObject) {
        let params        = STPCardParams()
            params.number = number.text!
            params.cvc    = cvv.text!
        
        if validateAndPay(params) {
            getToken(params)
        } else {
            showAlert("Form Error", message: "Please enter a valid credit card.")
        }
    }
    
    func validateAndPay(params:STPCardParams) -> Bool{

        //TODO - validate Name
        //TODO - validate credit card
        //TODO - validate mm
        //TODO - validate yy
        //TODO - validate cvc
        if expiration.text?.isEmpty != nil {
            let expArr = expiration.text?.componentsSeparatedByString("/")
            if expArr?.count >= 1 {
                let mm:NSNumber = UInt(expArr![0])!
                let yy:NSNumber = UInt(expArr![1])!
                
                params.expMonth = mm.unsignedLongValue
                params.expYear  = yy.unsignedLongValue
            }
            return true
        } else {
            return false
        }
    }
    
    func getToken(params:STPCardParams){
        STPAPIClient.sharedClient().createTokenWithCard(params, completion: { (token, stripeError) -> Void in
            if let error = stripeError {
                self.showAlert("Error", message: "Could not authorize")
            }
            else if let token = token {
                print("token:", token.tokenId)
            }
        })
    }
    
    func sendTokenToServer(tokenId:String){
        
    }
    
    func showAlert(title:String, message:String){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Payment Error", message:
            message, preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = mainTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
