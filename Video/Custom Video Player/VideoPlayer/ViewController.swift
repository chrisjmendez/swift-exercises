//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Ankit Shah on 09/09/15.
//  Copyright (c) 2015 Ankit Shah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, MoviePlayerDelegate {
    
    
    // Outlets for player container
    @IBOutlet weak var playerRightPin: NSLayoutConstraint!
    @IBOutlet weak var playerLeftPin: NSLayoutConstraint!
    @IBOutlet weak var playerTopPin: NSLayoutConstraint!
    @IBOutlet weak var playerBottomPin: NSLayoutConstraint!
    
    @IBOutlet weak var playerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let containerView = UIView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height))
//        self.view.addSubview(containerView)
        
        let moviePlayer = MoviePlayer(frame: CGRectMake(0, 0, self.view.frame.width, 200))
        moviePlayer.backgroundColor = colorWithHexString("000000")
        moviePlayer.setVideoUrl("http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8")
        // setup delegate
        moviePlayer.delegate = self
        playerContainer.addSubview(moviePlayer)
        
        // add constraint to your player view
        let horizonalContraints = NSLayoutConstraint(item: moviePlayer, attribute: .Leading, relatedBy: .Equal, toItem: playerContainer, attribute: .Leading, multiplier: 1.0, constant: 0)
        let horizonal2Contraints = NSLayoutConstraint(item: moviePlayer, attribute: .Trailing, relatedBy: .Equal, toItem: playerContainer, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let pinTop = NSLayoutConstraint(item: moviePlayer, attribute: .Top, relatedBy: .Equal, toItem: playerContainer, attribute: .Top, multiplier: 1.0, constant: 0)
        let pinBot = NSLayoutConstraint(item: moviePlayer, attribute: .Bottom, relatedBy: .Equal, toItem: playerContainer, attribute: .Bottom, multiplier: 1.0, constant: 0)
        moviePlayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([horizonalContraints, horizonal2Contraints, pinTop, pinBot])
        
        
    }
    
    func resizeButtonPressed() {
        var constraints = [playerRightPin, playerLeftPin, playerTopPin, playerBottomPin]
        var constants: [CGFloat] = [0, 0, 0, 0]
        if playerTopPin.constant == 0 { // video in full screen mode
            constants[0] = 20
            constants[1] = 20
            constants[2] = UIScreen.mainScreen().bounds.size.height / 5
            constants[3] = constants[2]
        }
        for i in 0..<constants.count {
            constraints[i].constant = constants[i]
        }
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func colorWithHexString(hexString: String) -> UIColor {
        let colorString = NSString(string: hexString.stringByReplacingOccurrencesOfString("#", withString: "").uppercaseString)
        var alpha: CGFloat, red: CGFloat, blue: CGFloat, green: CGFloat
        switch (colorString.length) {
        case 3: // #RGB
            alpha = 1.0
            red = colorComponentFrom(colorString, start: 0, length: 1)
            green = colorComponentFrom(colorString, start: 1, length: 1)
            blue = colorComponentFrom(colorString, start: 2, length: 1)
        case 4: // #ARGB
            alpha = colorComponentFrom(colorString, start: 0, length: 1)
            red = colorComponentFrom(colorString, start: 1, length: 1)
            green = colorComponentFrom(colorString, start: 2, length: 1)
            blue = colorComponentFrom(colorString, start: 3, length: 1)
        case 6: // #RRGGBB
            alpha = 1.0
            red = colorComponentFrom(colorString, start: 0, length: 2)
            green = colorComponentFrom(colorString, start: 2, length: 2)
            blue = colorComponentFrom(colorString, start: 4, length: 2)
        case 8: // #AARRGGBB
            alpha = colorComponentFrom(colorString, start: 0, length: 2)
            red = colorComponentFrom(colorString, start: 2, length: 2)
            green = colorComponentFrom(colorString, start: 4, length: 2)
            blue = colorComponentFrom(colorString, start: 6, length: 2)
        default:
            print("Color value \(hexString) is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB")
            return UIColor.clearColor()
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func colorComponentFrom(colorString: NSString, start: Int, length: Int) -> CGFloat {
        let subString = colorString.substringWithRange(NSMakeRange(start, length))
        let fullHex = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: CUnsignedInt = 0
        NSScanner(string: fullHex).scanHexInt(&hexComponent)
        
        return CGFloat(hexComponent) / 255.0
    }
}

