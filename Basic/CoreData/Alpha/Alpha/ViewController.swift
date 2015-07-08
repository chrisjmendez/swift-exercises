//
//  ViewController.swift
//  Alpha
//
//  Created by tommy trojan on 6/28/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBOutlet weak var fnameButton: UIButton!
    @IBOutlet weak var lnameButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fNameTextField.addTarget(self, action: "onChangeTextField:", forControlEvents: UIControlEvents.AllTouchEvents)
        lNameTextField.addTarget(self, action: "onChangeTextField:", forControlEvents: UIControlEvents.AllTouchEvents)
        emailTextField.addTarget(self, action: "onChangeTextField:", forControlEvents: UIControlEvents.AllTouchEvents)
        phoneTextField.addTarget(self, action: "onChangeTextField:", forControlEvents: UIControlEvents.AllTouchEvents)
        phoneButton.addTarget(self, action: "onButtonClickedHandler:", forControlEvents: UIControlEvents.AllTouchEvents)
    }
    
    func onButtonClickedHandler(sender:UIButton!){
        println("onButtonClickedHandler ")
        println(sender.dynamicType)
        println(sender.self)
        
        let ref = reflect(sender)
        println(ref, ref.count)
    }
    
    func onChangeTextField(sender:UITextField){

        switch sender {
        case let trigger as Int:
            println("Int")
        case let trigger as Double:
            println("Doube")
        case let trigger as UITextField:
            switch(sender){
            case fNameTextField:
                println("First Name")
            case lNameTextField:
                println("Last Name")
            case emailTextField:
                println("E-mail")
            case phoneTextField:
                println("Phone + \(trigger.placeholder)")
            default: break
            }
        case let trigger as UIButton:
            println("UiButton")
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
