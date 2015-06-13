//
//  DetailViewController.swift
//  Firebase
//
//  Created by tommy trojan on 6/11/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var webView: UIWebView!

    var detailItem: Item? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        //A. Make a request
        if let detail:Item = self.detailItem {
            //B. If there is a webView, load the URL
            if let view = self.webView {
                let url = detail.url
                let urlRequest = NSURLRequest(URL: url!)
                //C. Load the request
                view.loadRequest(urlRequest)
            }
        }
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.title = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
