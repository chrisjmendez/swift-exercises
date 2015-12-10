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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: NSMutableData = NSMutableData()
    var tData:NSArray = NSArray()
    
    @IBOutlet var appsTableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        iTunesSearch("stereolab");

        appsTableView?.delegate = self
        appsTableView?.dataSource = self
        
    }
    //iTunes API prefers + instead of %20 so we need to strip out the stuff
    func iTunesSearch(term: String) {
        // replace spaces with + symbol.
        let escapedTerm = (term as String).stringByReplacingSpaceWithPlusEncodingForQueryValue()!
        
        let myPath = "https://itunes.apple.com/search?term=\(escapedTerm)&media=all"
        
        let url:NSURL = NSURL(string: myPath)!
        print("URL for searching iTunes API \(url)")

        let request: NSURLRequest = NSURLRequest(URL: url)
        
        let ctn: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
            ctn.start()
        
    }
    /** ** ** ** ** ** ** ** ** ** ** **
    Receive the iTunes API Response
    ** ** ** ** ** ** ** ** ** ** ** **/
    //a cell function for creation and modification of cells for each row and a count function whose purpose is to count the number of rows
    func tableView(tView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tData.count
    }
   
    func tableView(tView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell for Testing")

        let rData: NSDictionary = self.tData[indexPath.row] as! NSDictionary
            cell.textLabel!.text = rData["trackName"] as? String

        // Grabbing the artworkUrl60 key for getting image URL for the thumbnail of the app
        let uString: NSString = rData["artworkUrl60"] as! NSString
        let iURL: NSURL = NSURL(string: uString as String)!
        
        // Download representation of the image as NSData at the URL
        let iData: NSData = NSData(contentsOfURL: iURL)!
            cell.imageView!.image = UIImage(data: iData)
        
        // obtain the formatted price string to be displayed on the subtitle
        let obj:Double = rData["trackPrice"]! as! Double
        
        if !isnan(obj) {
            let fPrice:String = "$ \(obj.toStringWithDecimalPlaces(2))"
            cell.detailTextLabel!.text = fPrice as String
        }
        
        return cell
    }
}

extension ViewController: NSURLConnectionDelegate, NSURLConnectionDataDelegate{
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
        
        let jResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        if jResult.count > 0 && jResult["results"]!.count > 0 {
            self.tData = (jResult["results"] as! NSArray)
            self.appsTableView!.reloadData()
        }
    }
}

extension String {
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    /// - returns: Return precent escaped string.
    func stringByReplacingSpaceWithPlusEncodingForQueryValue() -> String? {
        let term = self.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Anything which is not URL-friendly is escaped
        let escapedTerm = term.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        return escapedTerm
    }
}

extension Double {
    func toStringWithDecimalPlaces(numberOfDecimalPlaces:Int) -> String {
        return String(format:"%."+numberOfDecimalPlaces.description+"f", self)
    }
}
