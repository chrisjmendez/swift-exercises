//
//  ViewController.swift
//  Delegates
//
//  Created by Tommy Trojan on 12/11/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let message: String = "Marco!"

    var loader:UIActivityIndicatorView!
    var homingPigeon:HomingPigeon!
    
    @IBOutlet weak var senderTextField: UITextField!
    @IBOutlet weak var receiverTextField: UITextField!
    
    func initLoader(){
        loader = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX, y: view.frame.midY, width: 20, height: 20))
        loader.activityIndicatorViewStyle = .Gray
        loader.hidesWhenStopped = true
        loader.startAnimating()
        view.addSubview(loader)
    }
    
    func sendMessage(message:String){
        homingPigeon = HomingPigeon(message: message)
        homingPigeon.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initLoader()
    }
    
    override func viewWillAppear(animated: Bool) {
        senderTextField.text = message
    }
    
    override func viewDidAppear(animated: Bool) {
        sendMessage(message)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:HomingPigeonDelegate{
    func voyageDidFinish(message: String) {
        print("Reponse Delivered \(message)")
        loader.stopAnimating()
        receiverTextField.text = message
    }
}