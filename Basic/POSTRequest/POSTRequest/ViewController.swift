//
//  ViewController.swift
//  POSTRequest
//
//  Created by tommy trojan on 5/16/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTxt: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBAction func onButtonClicked(sender: AnyObject) {
        sendRequest()
    }

    func sendRequest(){
        let urlPath: String = "http://i.ng.ht/visitors/trace"
        var url: NSURL! = NSURL(string: urlPath)
        
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        var stringPost = "?email=" + inputTxt.text! + "&" + "timestamp=" + timestamp
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request1.HTTPMethod = "POST"
            request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request1.addValue("application/json", forHTTPHeaderField: "Accept")
            request1.timeoutInterval = 60
            request1.HTTPBody = data
            request1.HTTPShouldHandleCookies = false
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError

            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            println("AsSynchronous\(jsonResult)")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTxt.text = "test@maildrop.cc"
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
    /// :returns: Return precent escaped string.
    
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
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = map(self) { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return join("&", parameterArray)
    }
    
}