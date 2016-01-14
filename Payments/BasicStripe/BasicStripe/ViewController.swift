//
//  ViewController.swift
//  Stripe
//
//  Created by Tommy Trojan on 1/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {
    
    let SEGUE_TO_PAY = "toPaySegue"
    
    var products = [(name: "Pizza", price: "10"), (name: "Spagetti", price: "9.5"), (name: "Burger", price: "8")]
    
    @IBOutlet weak var productsTableView: UITableView!
    
    func onLoad(){
        //From table index cell
        productsTableView.delegate = self
        
        //From Buy Button
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToViewHandler:", name: "goToView", object: nil)
    }
    
    func goToViewHandler(notification:NSNotification){
        if let userInfo = notification.userInfo{
            print("goToViewHandler", userInfo)
            self.performSegueWithIdentifier(SEGUE_TO_PAY, sender: userInfo)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! PayViewController
        if let userInfo = sender! as? AnyObject{
            viewController.product = userInfo["item"]! as! String
            viewController.price   = userInfo["price"]! as! String
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        onLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UITableViewDataSource{
    
}

extension ViewController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath", indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Review the storyboard to see where we subclassed and named this view
        let cell: ProductsCell = tableView.dequeueReusableCellWithIdentifier("productsCell") as! ProductsCell
        cell.product.text = products[indexPath.row].name
        cell.price.text    = products[indexPath.row].price
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}
