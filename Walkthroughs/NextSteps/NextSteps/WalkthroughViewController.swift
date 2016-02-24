//
//  WalkthroughViewController.swift
//  NextSteps
//
//  Created by Chris Mendez on 2/23/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import Pages

class WalkthroughViewController: UIViewController {
    
    var pages:PagesController?
    
    func pagesControllerInCode() -> PagesController {
        
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = .blackColor()
        viewController1.title = "Controller A"
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .blueColor()
        viewController2.title = "Controller B"
        
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .redColor()
        viewController3.title = "Controller C"
        
        let viewController4 = UIViewController()
        viewController4.view.backgroundColor = .yellowColor()
        viewController4.title = "Controller D"
        
        let pages = PagesController([viewController1,
            viewController2,
            viewController3,
            viewController4
            ])
        
        pages.enableSwipe = true
        pages.showBottomLine = true
        
        return pages
    }
    
    func pagesControllerInStoryboard() -> PagesController {
        let storyboardIds = ["One","Two"]
        return PagesController(storyboardIds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       pages = pagesControllerInCode()
        
        self.view.window?.rootViewController = UINavigationController(rootViewController: pages!)
        
        pages?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page",
        style: .Plain,
        target: pages,
        action: "previous")
        
        pages?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page",
        style: .Plain,
        target: pages,
        action: "next")

        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
        
        
    }

}
