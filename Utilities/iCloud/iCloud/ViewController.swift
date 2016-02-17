//
//  ViewController.swift
//  iCloud
//
//  Created by Chris on 2/16/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    var docsDir:String?
    var fileMrg:NSFileManager?

    @IBOutlet weak var directoryNameTxt: UITextField!
    @IBOutlet weak var newDirectoryNameTxt: UITextField!
    
    @IBAction func onCreateDirectory(sender: AnyObject) {
        let newDir = docsDir?.NS.stringByAppendingPathComponent(directoryNameTxt.text!)
    }
    
    @IBAction func onCopyDirectory(sender: AnyObject) {
    }
    
    @IBAction func onMoveDirectory(sender: AnyObject) {
    }
    
    @IBAction func onDeleteDirectory(sender: AnyObject) {
    }
    
    @IBAction func onCheckDirectoryExists(sender: AnyObject) {
    }

    func onLoad(){
        fileMrg = NSFileManager()
        
        let directory = NSSearchPathDirectory(rawValue: 0)
        let domainMask = NSSearchPathDomainMask.UserDomainMask
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(directory!, domainMask, true)
        docsDir = dirPaths[0]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onLoad()
    }

}

public extension String {
    var NS: NSString { return (self as NSString) }
}