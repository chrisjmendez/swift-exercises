//
//  ViewController.swift
//  iTunesQuery
//
//  Created by tommy trojan on 5/17/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

/** ** ** ** ** ** ** ** ** **
Inspired by: http://technotif.com/connect-your-apps-to-itunes-search-api/
http://www.codingexplorer.com/getting-started-uitableview-swift/
** ** ** ** ** ** ** ** ** ** **/

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let api = APIController()
    
    var data: NSMutableData = NSMutableData()
    var tableData:NSArray = NSArray()
    
    @IBOutlet var appsTableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make an iTunes Query
        api.searchItunesFor("Angry Birds")
        //Set the delegate of the API controller
        api.delegate = self

        appsTableView?.delegate = self
        appsTableView?.dataSource = self
        
    }
    /** ** ** ** ** ** ** ** ** ** ** **
    Receive the iTunes API Response
    ** ** ** ** ** ** ** ** ** ** ** **/
    //a cell function for creation and modification of cells for each row and a count function whose purpose is to count the number of rows
    func tableView(tView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(tView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell for Testing")
        
        var rData: NSDictionary = self.tableData[indexPath.row] as! NSDictionary
        cell.textLabel!.text = rData["trackName"] as? String
        
        // Grabbing the artworkUrl60 key for getting image URL for the thumbnail of the app
        var uString: NSString = rData["artworkUrl60"] as! NSString
        var iURL: NSURL = NSURL(string: uString as String)!
        
        // Download representation of the image as NSData at the URL
        var iData: NSData = NSData(contentsOfURL: iURL)!
        cell.imageView!.image = UIImage(data: iData)
        
        // obtain the formatted price string to be displayed on the subtitle
        var obj:Double = rData["price"]! as! Double
        
        if !isnan(obj) {
            var fPrice:String = "$ \(obj.toStringWithDecimalPlaces(2))"
            cell.detailTextLabel!.text = fPrice as String
        }
        
        return cell
    }
}

extension SearchResultsViewController: APIControllerProtocol{
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = results
            self.appsTableView!.reloadData()
        })
    }
}

extension SearchResultsViewController: NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    /** ** ** ** ** ** ** ** ** ** ** **
    Receive the iTunes API Response
    ** ** ** ** ** ** ** ** ** ** ** **/
    //NSURLconnection receives the response, and then it will call the receivedResponse method.
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        // clear out the data object if a new request was received.
        self.data = NSMutableData()
    }
    
    //Once the connection is established, data will be received through the method receivedData().
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        // add the received data to the data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        // self.d should hold the resulting info, request is complete
        // received data is converted into an object through JSON deserialization
        var err: NSError
        
        var jResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        if jResult.count > 0 && jResult["results"]!.count > 0 {
            self.tableData = (jResult["results"] as! NSArray)
            self.appsTableView!.reloadData()
        }
    }
}

extension Double {
    func toStringWithDecimalPlaces(numberOfDecimalPlaces:Int) -> String {
        return String(format:"%."+numberOfDecimalPlaces.description+"f", self)
    }
}
