//
//  ViewController.swift
//  ShowHidePassword
//
//  Created by Tommy Trojan on 1/2/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//
//  Inspiration
//  http://www.peterboni.net/blog/2014/01/11/mobile-design-details-hide-show-passwords-ios-implementation-and-thoughts/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField:TextField!

    func initSecureText(tf:TextField){
        let w = 100
        let h = 60
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: w, height: h))
        button.titleLabel?.font = UIFont(name: "label", size: 14)
        button.setTitle("HIDE", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.init(hexString: "#678AFF") , forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("hideShow:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor(hexString: "#F0F0F0")
        button.layer.borderColor = UIColor(hexString: "#979797").CGColor
        
        tf.rightView = button
        tf.rightViewMode = UITextFieldViewMode.Always
    }
    
    func hideShow(sender:AnyObject){
        let button = sender as? UIButton
        let textfield = button?.superview as? TextField
        let isSecureText = textfield?.secureTextEntry as Bool!
        if isSecureText == false {
            textfield?.secureTextEntry = true
            button?.setTitle("SHOW", forState: UIControlState.Normal)
        }else{
            textfield?.secureTextEntry = false
            button?.setTitle("HIDE", forState: UIControlState.Normal)
        }
        button?.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initSecureText(passwordTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//Convert Hexadecimal to UIColor
//https://gist.github.com/arshad/de147c42d7b3063ef7bc
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}