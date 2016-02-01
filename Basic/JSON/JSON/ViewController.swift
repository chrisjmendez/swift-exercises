//
//  ViewController.swift
//  JSON
//
//  Created by Chris on 1/31/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let REDDIT = "https://www.reddit.com/new.json?limit=100"
    let HACKER_NEWS = "https://hacker-news.firebaseio.com/v0/topstories.json"
    
    func getJSON(url:String){
        Alamofire.request(.GET, REDDIT, parameters: nil).validate().responseJSON { response in
            switch response.result {
            case .Success:
                let data = response.result.value as? NSDictionary
                let json = JSON(data!)
                self.parseJSON(json)
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func parseJSON(json:JSON){
        print("JSON: \(json["data"]["children"][0]["data"]["title"])")
    }
    
    func onLoad(){
        getJSON(REDDIT)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
