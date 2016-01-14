//
//  PayViewController.swift
//  Stripe
//
//  Created by Tommy Trojan on 1/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    let HOST_URL = Config.host.url
    let URL_PATH = "/pay"

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
        STPAPIClient.sharedClient().createTokenWithCard(params, completion: { (token, error) -> Void in
            if let error = error {
                self.showAlert("Error", message: "Could not authorize. \(error)")
            }
            else if let token = token {
                self.preparePurchase(token.tokenId, params: params)
            }
        })
    }
    
    func preparePurchase(tokenId:String, params:STPCardParams){
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        var double = NSString(string: price).doubleValue
            double = double * 100
        let int = Int(double)
        
        let dict = [
            "stripeToken": "\(tokenId)",
            "amount":      "\(int)",
            "product":     "\(product)",
            "customer":    "\(name.text!)",
            "timestamp":   "\(timestamp)"
        ]
        postPayment(dict)
    }
    
    func postPayment(dict:[String:String]){   
        let data = dict.stringFromHttpParameters()

        let url = NSURL(string: URL_PATH, relativeToURL: NSURL(string: HOST_URL))
        let req = NSMutableURLRequest(URL: url!)
        req.HTTPMethod      = "POST"
        req.timeoutInterval = 60
        req.HTTPBody        = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        req.HTTPShouldHandleCookies = false
        
        let session  = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = session.dataTaskWithRequest(req) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil {
                    self.showAlert("Session Error", message: "There was an error processing your credit card \(error)")
                    return
                }
                self.processResponse(data!)
            })
        }
        dataTask.resume()
    }
    
    func processResponse(data:NSData){
            //JSON Response
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
                let success = json?.valueForKey("success") as! Int
                let message = json?.valueForKey("message")
                
                if success == 0 {
                    print("Fail: ", message)
                    self.showAlert("Payment Fail", message: "Your payment was not successful")
                } else {
                    print("Success: ", message)
                    self.showAlert("Payment Success", message: "Your payment was successful.")
                }
            } catch {
                let err = NSError(domain: self.HOST_URL, code: 1, userInfo: nil)
                print("Strange Error:", err)
            }
    }
    
    func showAlert(title:String, message:String){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: title, message:
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