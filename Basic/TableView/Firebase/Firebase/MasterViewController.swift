//
//  MasterViewController.swift
//  Firebase
//
//  Created by tommy trojan on 6/11/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    let BASE_URL = "http://hacker-news.firebaseio.com"
    
    //Schedule the download processes
    var operationQueue:NSOperationQueue = {
        var operationQueue = NSOperationQueue()
            operationQueue.name = "com.chrisjmendez.DownloadQueue"
            operationQueue.maxConcurrentOperationCount = 1
        
        return operationQueue
    }()
    
    var stories = NSMutableDictionary()
    
    /** ** ** ** ** ** ** ** ** ** ** **
    Apple's Code
    ** ** ** ** ** ** ** ** ** ** ** **/
    var objects = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        getTopStories()
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues
/*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as! NSDate
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }
*/
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
/*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }
*/
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

extension MasterViewController{

    //Get the top stories from Firebase
    private func getTopStories() -> Void{
        //A. Construct a URL
        let url = NSURL(string: BASE_URL + "/v0/topstories.json")
        //B. Construct a URL Request
        let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "GET"
        //C. Open a URLConnection and download the data
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.operationQueue, completionHandler: {[unowned self](response, responseData, error) -> Void in
            //D. Create a data object if there's responseData
            if let data = responseData{
                //E. Convert the Raw data into a JSON string
                let objects = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))) as? NSArray
                //F. Continue doing more processing
                self.downloadStoriesInformation(objects!)
            }
        })
    }
    
    //Get the story details and post them in a table view
    private func downloadStoriesInformation(storyIDs: NSArray) -> Void {
        let count = 2 //storyIDs.count
        
        for (index, storyID) in storyIDs.enumerate(){
            //A. Item detail story
            let storyURL = BASE_URL + "/v0/item/" + storyID.stringValue + ".json"
            //B. Craft a URL string
            let url = NSURL(string: storyURL)
            //C. Craft URL request
            var urlRequest = NSMutableURLRequest(URL: url!)
                urlRequest.HTTPMethod = "GET"
            //D. Async request
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.operationQueue, completionHandler: {
                [unowned self](res, resData, err) -> Void in
                //E. If data exists, process it
                if let data = resData {
                    if err != nil{
                        print("error", err)
                    }
                    //F. Convert data into JSON
                    let json = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))) as? NSDictionary
                    //G. Create an Item Object
                    let item = Item(dictionary: json as! [String: AnyObject])
                    //H. Store the Item object
                    self.stories.setObject(item, forKey: (storyID as! NSNumber))
                    //println("stories.objectForKey:", index, storyID)
                    //I. If detail data has been loaded
                    if index == count{
                        //J. Populate the table view
                        self.objects.removeAll(keepCapacity: false)
                        self.objects = storyIDs as NSArray as [(AnyObject)]
                        //K. Reload the table view
                        dispatch_async(dispatch_get_main_queue(), { [unowned self] in
                            self.tableView.reloadData()
                        })
                    }
                }
            })
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = self.objects[indexPath.row] as! NSNumber
        print("tableView", object, indexPath.row )

        let item = self.stories[object] as? Item
        if item != nil{
            cell.textLabel!.text = item!.title
        }
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSNumber
                let item = self.stories[object] as? Item

                (segue.destinationViewController as! DetailViewController).detailItem = item
            }
        }
    }

}

