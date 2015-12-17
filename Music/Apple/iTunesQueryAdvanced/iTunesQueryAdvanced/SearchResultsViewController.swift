//
//  ViewController.swift
//  iTunesQuery
//
//  Created by tommy trojan on 5/17/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

/** ** ** ** ** ** ** ** ** **
Inspired by: 
* http://technotif.com/connect-your-apps-to-itunes-search-api/
* http://www.codingexplorer.com/getting-started-uitableview-swift/
*
* Notes:
* In iOS we always want to use dequeueReusableCellWithIdentifier 
*   in order to get a cell out of memory if one is available, rather 
*   than creating a new one every time a cell is rendered.
* 
*
** ** ** ** ** ** ** ** ** ** **/

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableData = []
    let api = APIController()
    let kCellIdentifier: String = "SearchResultCell"
    @IBOutlet weak var appsTableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.delegate = self
        api.searchItunesFor("stereolab", searchCategory: "music")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell!
        
        if let rowData: NSDictionary = self.tableData[indexPath.row] as? NSDictionary,
            // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
            urlString = rowData["artworkUrl60"] as? String,
            imgURL = NSURL(string: urlString),
            // Get the formatted price string for display in the subtitle
            formattedPrice = rowData["trackPrice"] as? Double,
            // Download an NSData representation of the image at the URL
            imgData = NSData(contentsOfURL: imgURL),
            // Get the track name
            trackName = rowData["trackName"] as? String {
                // Get the formatted price string for display in the subtitle
                cell.detailTextLabel?.text = formattedPrice.toStringWithDecimalPlaces(2)
                // Update the imageView cell to use the downloaded image data
                cell.imageView?.image = UIImage(data: imgData)
                // Update the textLabel text to use the trackName from the API
                cell.textLabel?.text = trackName
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get the row data for the selected row
        if let rowData = self.tableData[indexPath.row] as? NSDictionary,
            // Get the name of the track for this row
            name = rowData["trackName"] as? String,
            // Get the price of the track on this row
            formattedPrice = rowData["trackPrice"] as? Double {
                print("formattedPrice:", formattedPrice)
                let alert = UIAlertController(title: name, message: formattedPrice.toStringWithDecimalPlaces(2), preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
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

extension Double {
    func toStringWithDecimalPlaces(numberOfDecimalPlaces:Int) -> String {
        return String(format:"$%."+numberOfDecimalPlaces.description+"f", self)
    }
}
