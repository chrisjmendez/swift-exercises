// Playground - noun: a place where people can play

import UIKit
import XCPlayground

let frame = CGRectMake(0, 0, 300, 300)

let ani = CABasicAnimation(keyPath: "borderWidth")
    ani.fromValue = 1
    ani.toValue = 100
    ani.duration = 5

let view = UIView(frame: frame)

XCPShowView("View", view)

view.backgroundColor = UIColor.blueColor()
view.layer.borderWidth = 5;
view.layer.addAnimation(ani, forKey: "borerWidth")

let img = UIImageView(image: UIImage(named: "items.png"))

