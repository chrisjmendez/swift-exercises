//
//  ViewController.swift
//  BasicDropBox
//
//  Created by Chris on 1/15/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import SwiftyDropbox

class ViewController: UIViewController {

    var dropBoxUtil:DropboxUtil?

    
    @IBOutlet weak var authenticateBtn: UIButton!
    
    @IBAction func onAuthenticate(sender: AnyObject) {
        Dropbox.authorizeFromController(self)
    }
    
    func onLoad() {
        dropBoxUtil = DropboxUtil()
        dropBoxUtil?.getUserAccount()
        dropBoxUtil?.listFolder()
    }
    
    func hideButton(){
        authenticateBtn.hidden = true
    }
    
    func showButton(){
        authenticateBtn.hidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideButton()
        
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

