//
//  ViewController.swift
//  Timeline
//
//  Created by Chris on 2/1/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController {

    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    
    let REDDIT = "https://www.reddit.com/new.json?limit=100"
    let HACKER_NEWS = "https://hacker-news.firebaseio.com/v0/topstories.json"
    
    var events:[TimeFrame] = [
        TimeFrame(text: "New Year's Day", date: "January 1", image: UIImage(named: "fireworks.jpeg")),
        TimeFrame(text: "The month of love!", date: "February 14", image: UIImage(named: "heart.png")),
        TimeFrame(text: "Comes like a lion, leaves like a lamb", date: "March",  image: nil),
        TimeFrame(text: "Dumb stupid pranks.", date: "April 1", image: UIImage(named: "april.jpeg")),
        TimeFrame(text: "That's right. No image is necessary!", date: "No image?", image: nil),
        TimeFrame(text: "This control can stretch. It doesn't matter how long or short the text is, or how many times you wiggle your nose and make a wish. The control always fits the content, and even extends a while at the end so the scroll view it is put into, even when pulled pretty far down, does not show the end of the scroll view.", date: "Long text", image: nil),
        TimeFrame(text: "Hope this helps someone!", date: "That's it!", image: nil)
    ]
    
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
        
        initScrollView(events)
    }
    
    func onLoad(){
        getJSON(REDDIT)
    }
    
    func initScrollView(timeFrames:[TimeFrame]){
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 29),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
        
        timeline = TimelineView(bulletType: .Circle, timeFrames: timeFrames )
        scrollView.addSubview(timeline)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: timeline, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0)
            ])
        
        view.sendSubviewToBack(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

