//
//  ViewController.swift
//  HTTPRequests
//
//  Created by tommy trojan on 5/17/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
//https://github.com/daltoniam/swiftHTTP
import SwiftHTTP

class ViewController: UIViewController {
    
    let logo:String = "https://pbs.twimg.com/profile_images/596047686089871360/TqOLJ2cz.png"

    @IBAction func onGETClicked(sender: AnyObject) {
        basicGET()
    }
    
    @IBAction func onPOSTClicked(sender: AnyObject) {
        basicPOST()
    }
    
    @IBAction func onDownloadClicked(sender: AnyObject) {
        basicDownload()
    }

    @IBAction func onPOSTAPIClicked(sender: AnyObject) {
        basicPOSTAPI()
    }
    
    
    func basicGET(){
        
        var request = HTTPTask()
        request.GET("http://i.ng.ht/visitors/trace",
            parameters: nil,
            success: {(response: HTTPResponse) -> Void in
                if let data = response.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("response: \(str)") //prints the HTML of the page
                }
            },
            failure: {(error: NSError, response: HTTPResponse?) -> Void in
                println("got an error: \(error)")
        })
    }
    
    func basicPOST(){
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: Dictionary<String,AnyObject> = ["param": "param1", "array": ["first array element","second","third"], "num": 23, "dict": ["someKey": "someVal"]]

        var request = HTTPTask()
        request.POST("http://i.ng.ht/visitors/trace", parameters: params, success: {(response: HTTPResponse) in
                if let data = response.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("response: \(str)")
                }
            }, failure: {(error: NSError, response: HTTPResponse?) -> Void in
                println("got an error: \(error)")
        })
    }
    
    func basicDownload(){
        var request = HTTPTask()
        let downloadTask = request.download(logo,
            parameters: nil,
            progress: {(complete: Double) in
            println("percent complete: \(complete)")
            },
            success: {(response: HTTPResponse) in
                println("download finished!")
                if let url = response.responseObject as? NSURL {
                    //we MUST copy the file from its temp location to a permanent location.
                    if let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as? String {
                        if let fileName = response.suggestedFilename {
                            if let newPath = NSURL(fileURLWithPath: "\(path)/\(fileName)") {
                                let fileManager = NSFileManager.defaultManager()
                                fileManager.removeItemAtURL(newPath, error: nil)
                                fileManager.moveItemAtURL(url, toURL: newPath, error:nil)
                            }
                        }
                    }
                }
        },
        failure: {(error: NSError, response: HTTPResponse?) -> Void in
            println("error: \(error.localizedDescription)")
            return //also notify app of failure as needed
        })
    }
    
    func basicPOSTAPI(){
        var request = HTTPTask()
        request.baseURL = "http://i.ng.ht/"
        request.POST("/visitors/trace", parameters: ["key": "updatedVale"], success: {(response: HTTPResponse) in
            println("Got data from \(response.text)")
        },
        failure: {(error: NSError, response: HTTPResponse?) -> Void in
                println("error: \(error.localizedDescription)")
                return //also notify app of failure as needed
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

