//
//  TableViewController.swift
//  ParseDelta
//
//  Created by tommy trojan on 6/24/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Parse

class TableViewController: PFQueryTableViewController {
    
    let className:String = "Countries"
    let colName          = ("nameEnglish", "capital")
    let condition        = (key: "currencyCode", value: "EUR")
    let rowsPerPage:UInt = 20
    //Main.storyboard -> TableViewController -> PrototypeCell -> Identifier
    let prototypeCellID  = "Cell"
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        // Configure the PFQueryTableView
        self.parseClassName       = className
        self.textKey              = colName.0
        self.pullToRefreshEnabled = true
        self.paginationEnabled    = false
        self.objectsPerPage       = rowsPerPage
    }
   
    //Query Parse
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: className)
            query.orderByAscending(colName.0)
            query.whereKey(condition.key, containsString: condition.value)
        
        return query
    }
    
    //Get the data from Parse, publish it into a cell, the populate the table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell = tableView.dequeueReusableCellWithIdentifier(prototypeCellID) as! PFTableViewCell!
        if cell == nil{
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: prototypeCellID)
        }
        //Extract values from the PFObject to display in the table cell
        if let nameEnglish = object?[colName.0] as? String{
            cell?.textLabel?.text = nameEnglish
        }
        if let capital = object?[colName.1] as? String{
            cell?.detailTextLabel?.text = capital
        }
        return cell
    }
    
    //Find the next view, pass new data to that view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Identify the next view controller
        var nextScene = segue.destinationViewController as! DetailViewController
        //Pass the object to the next view controller
        if let indexPath = self.tableView.indexPathForSelectedRow(){
            let row = Int(indexPath.row)
            
            nextScene.currentObj = (objects?[row] as! PFObject)
        }
    }
}
