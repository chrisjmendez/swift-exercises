//
//  PayViewController.swift
//  Stripe
//
//  Created by Tommy Trojan on 1/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    var product:String = ""
    var price:String   = ""
    
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
                self.sendTokenToServer(token.tokenId, params: params)
            }
        })
    }
    
    func sendTokenToServer(tokenId:String, params:STPCardParams){
        print("C", product, price, tokenId, params )
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)

        var double = NSString(string: price).doubleValue
            //double = double * 100
        let int = Int(double)
        
        let dict = [
            "price": "\(int)",
            "type": "\(product)",
            "customer": "\(name.text!)"
        ]
        
        print(dict)
        
        let data = "?" + dict.stringFromHttpParameters()
        
        let url = NSURL(string: "/pay")
        let req = NSMutableURLRequest(URL: url!)
            req.HTTPMethod = "POST"
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.timeoutInterval = 60
            req.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            req.HTTPShouldHandleCookies = false

        let session  = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = session.dataTaskWithRequest(req) { (data, response, error) -> Void in
            if error != nil {
                self.showAlert("Session Error", message: "There was an error processing your credit card \(error)")
            }
            
            if data != nil {
                let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                print("AsSynchronous\(jsonResult)")
            }
        }
        dataTask.resume()
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
        title = product
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension String {
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns: Return precent escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
    
}

extension Dictionary {
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}