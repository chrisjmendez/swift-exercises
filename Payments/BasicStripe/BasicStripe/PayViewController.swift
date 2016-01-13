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
        validateAndPay()
    }
    
    func validateAndPay(){
        let creditCard = STPCardParams()
        creditCard.number = number.text
        creditCard.cvc    = cvv.text
        
        if(((expiration.text?.isEmpty) == nil)){
            let expArr = expiration.text?.componentsSeparatedByString("/")
            if expArr?.count > 1 {
                
                let mm:NSNumber = Int(expArr![0])!
                let yy:NSNumber = Int(expArr![1])!
                
                creditCard.expMonth = mm.unsignedLongValue
                creditCard.expYear  = yy.unsignedLongValue
            }
        }
        
        do {
            try creditCard.validateCardReturningError()
            /*
            STPAPIClient.sharedClient().createTokenWithCard(
                creditCard,
                completion: { (token: STPToken?, stripeError: NSError?) -> Void in
                    self.createBackendChargeWithToken(token!, completion: completion)
            })
            */
            print("validated")

        } catch {
            showAlert()
        }
    }
    
    func showAlert(){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Payment Error", message:
            "Please enter a valid credit card.", preferredStyle: .Alert)
        
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
