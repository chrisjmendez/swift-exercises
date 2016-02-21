//
//  ClientContentViewController.swift
//  Presentation
//
//  Created by Chris on 2/19/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ClientContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var pageIndex:Int?
    var titleText:String?
    var imageFile:String?
    
    func onLoad(){
        self.titleLabel.text = titleText
        self.backgroundImageView.image = UIImage(named: imageFile!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }    
}
