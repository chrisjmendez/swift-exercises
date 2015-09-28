//
//  DetailViewController.swift
//  UITableView
//
//  Created by Tommy Trojan on 9/28/15.
//  Copyright (c) 2015 Skyground Media. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var detailItem: String?
    
    //Print whatever comes from the segue
    func updateNavigationTitle(){
        
        if let data:String = self.detailItem {
            self.navigationItem.title = "A"
            self.title = data
        }
        
    }
    
    func updateBackButtonTitle(){
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidLoad() {
        self.updateBackButtonTitle()
        self.updateNavigationTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
