//
//  DropboxUtil.swift
//  BasicDropBox
//
//  Created by Chris on 1/16/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//
// https://www.dropbox.com/developers/documentation/swift#tutorial

import UIKit
import SwiftyDropbox

class DropboxUtil {
    
    let DROPBOX_FOLDER_PATH = "SwiftHero"

    var client:DropboxClient?
    
    init(){
        //super.init()
        if let cli = Dropbox.authorizedClient {
            client = cli
        }
    }
    
    func getUserAccount(){
        print("getUserAccount")
        //A. Get the current user's account info
        client?.users.getCurrentAccount().response({ (response, error) -> Void in
            print("*** Get current account ***")
            if error != nil {
                print("Error:", error!)
            }
            
            if let account = response {
                print("Hello \(account.name.givenName)!")
            }
        })
    }
    
    func listFolder(){
        client?.files.listFolder(path: "./").response( { (response, error) -> Void in
            print("*** List folder ***")
            if let result = response {
                print("Folder contents:")
                for entry in result.entries {
                    print(entry.name)
                }
            } else {
                print(error!)
            }
        })
    }
    
}