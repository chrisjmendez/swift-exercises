//
//  ViewController.swift
//  Cards
//
//  Created by Chris on 1/31/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let SEGUE_ON_LOAD = "onLoadSegue"
    
    let REDDIT        = "https://www.reddit.com/new.json?limit=10"
    
    var json:JSON?
    
    func getJSON(url:String){
        Alamofire.request(.GET, url, parameters: nil).validate().responseJSON { response in
            switch response.result {
                case .Success:
                    let data = response.result.value as? NSDictionary
                    let json = JSON(data!)
                    self.parseJSON(json)
                    self.goToView(self.SEGUE_ON_LOAD)
                case .Failure(let error):
                    print(error)
            }
        }
    }
    
    func parseJSON(json:JSON){
        self.json = json["data"]["children"]
    }
    
    func goToView(identifier:String){
        self.performSegueWithIdentifier(identifier, sender: self)
    }
    
    func onLoad(){
        getJSON(REDDIT)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_ON_LOAD {
            let vc = segue.destinationViewController as! CardsTableViewController
                vc.json = self.json
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }

}
