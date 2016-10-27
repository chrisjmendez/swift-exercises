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
    
    func getJSON(_ url:String){
        Alamofire.request(REDDIT, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success:
                let data = response.result.value as? NSDictionary
                let json = JSON(data!)
                self.parseJSON(json)
            case .failure(let error):
                print("ERROR:", error)
            }
        }
    }
    
    func parseJSON(_ json:JSON){
        print("\n\nJSON: \(json["data"]["children"][0]["data"]["title"])\n\n")
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
