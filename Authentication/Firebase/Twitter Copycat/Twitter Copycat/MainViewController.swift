//
//  MainViewController.swift
//  Twitter Copycat
//
//  Created by Tommy Trojan on 9/25/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let SEGUE_LOGOUT = "onLogoutSegue"
    
    let REUSABLE_CELL = "cell"
    
    let TOP_LEVEL_NODE  = "Posts"

    var db = Firebase(url: Config.db.uri)

    //Dictionary of data pulled from Firebase
    var posts: [String: String] = [String: String]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(REUSABLE_CELL) as! UITableViewCell

        //Test: Get keys from the Dictionary
        var keys = Array(self.posts.keys)

        cell.textLabel?.text = posts[keys[indexPath.row]] as String!

        return cell
    }

    @IBAction func onLogout(sender: AnyObject) {
        //Logout of Firebase
        db.unauth()
        //Go To Main view of app
        self.performSegueWithIdentifier(SEGUE_LOGOUT, sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    //Loads the data from Firebase
    func loadData(){
        //Observe when changes have been made to Firebase
        db.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            self.posts = snapshot.value.objectForKey("Posts") as! [String: String]
            //Updates the tableview every time there is a new post
            self.tableView.reloadData()
        })
    }
}
