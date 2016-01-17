//
//  ViewController.swift
//  TipView
//
//  Created by Chris on 1/16/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var easyTipPreferences = EasyTipView.Preferences()
    
    @IBOutlet weak var tip1: UIButton!
    @IBOutlet weak var tip2: UIButton!
    
    @IBAction func onTap2(sender: AnyObject) {
        EasyTipView.showAnimated(true,
            forView: self.tip2,
            withinSuperview: self.navigationController?.view,
            text: "Tip view inside the navigation controller's view. Tap to dismiss!",
            preferences: easyTipPreferences,
            delegate: self)
    }
    
    @IBOutlet weak var tip3: UIButton!
    
    func onLoad(){
        
        
        easyTipPreferences.drawing.font = UIFont(name: "Helvetica", size: 13)!
        easyTipPreferences.drawing.foregroundColor = UIColor.blackColor()
        easyTipPreferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        easyTipPreferences.drawing.arrowPosition = EasyTipView.ArrowPosition.Top
        
        EasyTipView.globalPreferences = easyTipPreferences
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


extension ViewController:EasyTipViewDelegate{
    func easyTipViewDidDismiss(tipView : EasyTipView){
        print("tipView")
    }
}