//
//  CardsTableViewController.swift
//  Cards
//
//  Created by Chris on 1/31/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import Async
import UIKit
import SwiftyJSON
import WildcardSDK

class CardsTableViewController: UITableViewController {

    let WCRedditCardTableViewCellCardViewTag = 1
    
    let HOST_URL = "http://reddit.com/"
    
    var cards = []
    var json:JSON?
    
    func onLoad(){
        let str = json![0]["data"]
        print(str)
    }
    
    func initTableView(){
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.estimatedRowHeight = 50.0;
    }
    
    func getTitle(index:Int) -> String {
        let str = json![index]["data"]["author"].string!
        return str
    }
    
    func getURL(index:Int) -> String {
        let str = json![index]["data"]["url"].string!
        return str
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onLoad()
        initTableView()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = json?.count {
            if rows > 0 {
                return rows
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let url = NSURL(string: getURL(indexPath.row), relativeToURL: NSURL(string: HOST_URL))
        
        //Dynamically create and Style a Prototype Cell
        let reuseIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style:.Default, reuseIdentifier: reuseIdentifier)
        }
        
        cell.contentView.viewWithTag(self.WCRedditCardTableViewCellCardViewTag)?.removeFromSuperview()
        
        Card.getFromUrl(url) { (card, error) -> Void in
            if error != nil {
                print("error:", error)
            } else {
                let cardView = CardView.createCardView(card)!
                    cardView.translatesAutoresizingMaskIntoConstraints = true
                    cardView.tag = self.WCRedditCardTableViewCellCardViewTag
                
                //cardView.horizontallyCenterToSuperView(0)
                //cardView.constrainTopToSuperView(10)
                //cardView.constrainBottomToSuperView(10)
                cell.contentView.addSubview(cardView)
            }
        }
        
        //cell.textLabel?.text = getTitle(indexPath.row)
        //cell.backgroundColor = UIColor.clearColor()
        //cell.selectionStyle  = UITableViewCellSelectionStyle.Default
        //cell.imageView.image = createThumbnail("")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath", indexPath.row)
        
    }
}

extension CardsTableViewController:CardViewDelegate{
    func cardViewRequestedAction(cardView: CardView, action: CardViewAction) {
        handleCardAction(cardView, action: action)
    }
}