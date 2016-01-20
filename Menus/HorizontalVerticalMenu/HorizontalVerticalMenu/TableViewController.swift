//
//  TableViewController.swift
//  HorizontalVerticalMenu
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import QuartzCore
import CoreImage
import Persei


class TableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!

    private weak var menu: MenuView!
    
    // MARK: - Actions
    @IBAction
    private func switchMenu() {
        menu.setRevealed(!menu.revealed, animated: true)
    }
    
    func onLoad(){
        let menu = MenuView()
        menu.delegate = self
        menu.items = items
        
        tableView.addSubview(menu)
        
        self.menu = menu
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        onLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print(imageView.bounds.size)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Items
    private let items = (0..<7 as Range).map {
        MenuItem(image: UIImage(named: "menu_icon_\($0)")!)
    }
    
    // MARK: - Model
    private var model: ContentType = ContentType.Films {
        didSet {
            title = model.description
            
            if isViewLoaded() {
                let center: CGPoint = {
                    let itemFrame = self.menu.frameOfItemAtIndex(self.menu.selectedIndex!)
                    let itemCenter = CGPoint(x: itemFrame.midX, y: itemFrame.midY)
                    var convertedCenter = self.imageView.convertPoint(itemCenter, fromView: self.menu)
                    convertedCenter.y = 0
                    
                    return convertedCenter
                }()
                
                let transition = CircularRevealTransition(layer: imageView.layer, center: center)
                transition.start()
                
                imageView.image = model.image
            }
        }
    }

}

// MARK: - MenuViewDelegate
extension TableViewController: MenuViewDelegate {
    func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
        model = model.next()
    }
}