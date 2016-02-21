//
//  ViewController.swift
//  Presentation
//
//  Created by Chris on 2/19/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    let PAGE_VC_STORYBOARD_ID    = "pageViewController"
    let CONTENT_VC_STORYBOARD_ID = "contentViewController"
    
    var pageViewController:UIPageViewController?
    let pageTitles:[String] = ["Screenshot #01", "Screenshot #02", "Screenshot #03", "Screenshot #04"]
    let pageImages:[String] = [ "page1", "Slide02", "Slide03", "Slide04"]
    
    @IBAction func onStart(sender: AnyObject) {
        startWalkthrough("reverse")
    }
    
    func startWalkthrough(dir:String){
        let startingViewController:ClientContentViewController = viewControllerAtIndex(0)!
        let viewControllers:[UIViewController] = [startingViewController]
        
        if dir == "forward" {
            pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        } else {
            pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Reverse, animated: false, completion: nil)
        }
    }
    
    func onLoad(){
        //Instantiate a Page View Controller
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier(PAGE_VC_STORYBOARD_ID)
            as? UIPageViewController
        //Assign the data source
        pageViewController?.dataSource = self

        startWalkthrough("forward")

        let w = self.view.frame.width
        let h = self.view.frame.height
        pageViewController!.view.frame = CGRect(x: 0, y: 0, width: w, height: h - 50)

        self.addChildViewController(pageViewController!)
        view.addSubview( (pageViewController?.view)! )
        
        pageViewController?.didMoveToParentViewController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onLoad()
    }
}


extension ViewController:UIPageViewControllerDataSource{

    // MARK: - Page View Controller Data Source

    //Create the necessary Page Content View
    func viewControllerAtIndex(index:Int) -> ClientContentViewController? {
        if ( pageTitles.count == 0) || (index >= pageTitles.count ) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentVC = self.storyboard?.instantiateViewControllerWithIdentifier(CONTENT_VC_STORYBOARD_ID) as! ClientContentViewController
            pageContentVC.imageFile = self.pageImages[index]
            pageContentVC.titleText = self.pageTitles[index]
            pageContentVC.pageIndex = index
        
        return pageContentVC
    }
    
    //we tell the app what to display when user switches back to the previous screen
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! ClientContentViewController).pageIndex
        if ((index == 0) || (index == nil)) {
            return nil
        }
        
        index = index! - 1
        
        return viewControllerAtIndex(index!)
    }
    
    //we tell the app what to display for the next screen
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ClientContentViewController).pageIndex
        if index == nil {
            return nil
        }
        
        index = index! + 1
        
        if index == self.pageTitles.count {
            return nil
        }
        
        return viewControllerAtIndex(index!)
    }
    
    // MARK: - Page View Controller indicator dots
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
}