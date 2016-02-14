//
//  ViewController.swift
//  Permissions
//
//  Created by Chris on 2/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import PermissionScope

class ViewController: UIViewController {

    let pscope = PermissionScope()

    @IBOutlet weak var onSubmit: UIButton!
    @IBAction func onSubmit(sender: AnyObject) {
        
        showPermissions()
    }
    
    
    func showPermissions(){
        // Set up permissions
        pscope.addPermission(ContactsPermission(),
            message: "We use this to steal\r\nyour friends")
        pscope.addPermission(NotificationsPermission(notificationCategories: nil),
            message: "We use this to send you\r\nspam and love notes")
        pscope.addPermission(LocationWhileInUsePermission(),
            message: "We use this to track\r\nwhere you live")
        
        // Show dialog with callbacks
        pscope.show({ finished, results in
            print("got results \(results)")
            }, cancelled: { (results) -> Void in
                print("thing was cancelled")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

