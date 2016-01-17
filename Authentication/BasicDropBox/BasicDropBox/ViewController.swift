//
//  ViewController.swift
//  BasicDropBox
//
//  Created by Chris on 1/15/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import SwiftyDropbox
import SCLAlertView

class ViewController: UIViewController {

    var dropBoxUtil:DropboxUtil?

    @IBOutlet weak var authenticateBtn: UIButton!
    
    @IBAction func onAuthenticate(sender: AnyObject) {
        
        Dropbox.authorizeFromController(self)
    }
    
    @IBAction func listFolder(sender: AnyObject) {
        dropBoxUtil?.listFolder()
    }
    
    @IBAction func getAccountInfo(sender: AnyObject) {
        dropBoxUtil?.getUserAccount()
    }
    
    @IBAction func uploadFile(sender: AnyObject) {
        uploadFile()
    }
    
    @IBAction func downloadFile(sender: AnyObject) {
    }
    
    func onLoad() {
        dropBoxUtil = DropboxUtil()
        dropBoxUtil!.delegate = self
    }
    
    func uploadFile(){
        let client = dropBoxUtil?.client
        let fileData = "Hello!".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        client?.files.upload(path: "/hello.txt", body: fileData!).response { response, error in
            if let metadata = response {
                print("*** Upload file ****")
                print("Uploaded file name: \(metadata.name)")
                print("Uploaded file revision: \(metadata.rev)")
                
                // Get file (or folder) metadata
                client?.files.getMetadata(path: "/hello.txt").response { response, error in
                    print("*** Get file metadata ***")
                    if let metadata = response {
                        if let file = metadata as? Files.FileMetadata {
                            print("This is a file with path: \(file.pathLower)")
                            print("File size: \(file.size)")
                        } else if let folder = metadata as? Files.FolderMetadata {
                            print("This is a folder with path: \(folder.pathLower)")
                        }
                    } else {
                        print(error!)
                    }
                }
                
                // Download a file
                
                let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { temporaryURL, response in
                    let fileManager = NSFileManager.defaultManager()
                    let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                    // generate a unique name for this file in case we've seen it before
                    let UUID = NSUUID().UUIDString
                    let pathComponent = "\(UUID)-\(response.suggestedFilename!)"
                    return directoryURL.URLByAppendingPathComponent(pathComponent)
                }
                
                client?.files.download(path: "/hello.txt", destination: destination).response { response, error in
                    if let (metadata, url) = response {
                        print("*** Download file ***")
                        let data = NSData(contentsOfURL: url)
                        print("Downloaded file name: \(metadata.name)")
                        print("Downloaded file url: \(url)")
                        print("Downloaded file data: \(data)")
                    } else {
                        print(error!)
                    }
                }
                
            } else {
                print(error!)
            }
        }
    }
    
    func showAlert(title:String, message:String){
        print(title, message)
        let alert = SCLAlertView()
        alert.showTitle(
            "Congratulations", // Title of view
            subTitle: "Operation successfully completed.", // String of view
            duration: 0.0, // Duration to show before closing automatically, default: 0.0
            completeText: "Done", // Optional button value, default: ""
            style: SCLAlertViewStyle.Success,
            colorStyle: 0xA429FF,
            colorTextButton: 0xFFFFFF
        )
        
        alert.showInfo(title, subTitle: message)
        alert.showInfo("Edit View", subTitle: "This alert view shows a text box")
        let txt = alert.addTextField("Enter your name")
        alert.addButton("Show Name") {
            print("Text value: \(txt.text)")
        }
    }
    
    func hideButton(){
        authenticateBtn.hidden = true
    }
    
    func showButton(){
        authenticateBtn.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideButton()
        
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:DropboxUtilDelegate{
    func didAuthenticate(success: Bool) {
        print("A", success)
        
        if success == true {
            showAlert("Authentication Success", message: "You've successfully authenticated your Dropbox account.")
            hideButton()
        } else {
            showAlert("Authentication Fail", message: "Uh oh. Something went wrong. Let's try again")
            showButton()
        }
    }
}