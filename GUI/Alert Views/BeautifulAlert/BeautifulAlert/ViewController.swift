//
//  ViewController.swift
//  BeautifulAlert
//
//  Created by Chris on 1/16/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import SCLAlertView

class ViewController: UIViewController {

    enum AlertType: CGFloat{
        case Basic   = 0
        case Error   = 1
        case Warning = 2
        case Notice  = 3
        case Info    = 4
        case Edit    = 5
    }
    
    @IBAction func onSimpleAlert(sender: AnyObject) {
        showAlert(AlertType.Basic,
            title: "Important info",
            message: "Congratulations! You've been selected")
    }
    
    @IBAction func onError(sender: AnyObject) {
        showAlert(AlertType.Error,
            title: "Important info",
            message: "Congratulations! You've been selected")
    }
    
    @IBAction func onWarning(sender: AnyObject) {
        showAlert(AlertType.Warning,
            title: "Important info",
            message: "Congratulations! You've been selected")
    }
    
    @IBAction func onNotice(sender: AnyObject) {
        showAlert(AlertType.Notice,
            title: "Important info",
            message: "Congratulations! You've been selected")
    }
    
    @IBAction func onInfo(sender: AnyObject) {
        showAlert(AlertType.Info,
            title: "Important info",
            message: "Congratulations! You've been selected")
    }
    
    @IBAction func onEdit(sender: AnyObject) {
        showAlert(AlertType.Edit,
            title: "Important info",
            message: "Congratulations! You've been selected")
    }
    
    func showAlert(type:AlertType, title:String, message:String){
        switch(type){
        case AlertType.Basic:
            // Get started
            let alert = SCLAlertView()
            alert.showTitle(
                "Congratulations", // Title of view
                subTitle: "Operation successfully completed.", // String of view
                duration: 0.0, // Duration to show before closing automatically, default: 0.0
                completeText: "Done", // Optional button value, default: ""
                style: SCLAlertViewStyle.Success,
                colorStyle: 0xA429FF,
                colorTextButton: 0xFFFFFF
            )
            alert.showInfo(title, subTitle: message)
            alert.showEdit("Edit View", subTitle: "This alert view shows a text box")
            let txt = alert.addTextField("Enter your name")
            alert.addButton("Show Name") {
                print("Text value: \(txt.text)")
            }
            break
        case AlertType.Error:
            SCLAlertView().showError("Hello Error", subTitle: "This is a more descriptive error text.") // Error
            break
        case AlertType.Warning:
            SCLAlertView().showWarning("Hello Warning", subTitle: "This is a more descriptive warning text.") // Warning
            break
        case AlertType.Notice:
            SCLAlertView().showNotice("Hello Notice", subTitle: "This is a more descriptive notice text.") // Notice
            break
        case AlertType.Info:
            SCLAlertView().showInfo("Hello Info", subTitle: "This is a more descriptive info text.") // Info
            break
        case AlertType.Edit:
            SCLAlertView().showEdit("Hello Edit", subTitle: "This is a more descriptive info text.") // Edit
            break
        default:
            break
        }

    }
    
    didau
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

