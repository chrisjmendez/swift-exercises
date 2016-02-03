//
//  ViewController.swift
//  SendBirdChat
//
//  Created by Chris on 2/2/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit
import SendBirdSDK

class ViewController: UIViewController {

    //let APP_ID  = "20A47365-FD27-41AF-AE3C-EBBC1FDE878C"
    let APP_ID  = "A7A2672C-AD11-11E4-8DAA-0A18B21C2D82"
    let USER_ID = SendBird.deviceUniqueID()

    //let channelURL  = "6aa6f.localsonly"
    let channelURL = "jia_test.Lobby"

    var startMessagingFromOpenChat = false
    var messagingTargetUserId = ""
    
    var chattingVC:ChattingTableViewController?
    var messagingVC:MessagingTableViewController?
    
    @IBAction func onStartOpenChat(sender: AnyObject) {
        startOpenChat()
    }
    
    @IBAction func onStartMessage(sender: AnyObject) {
        startMessage()
    }
    
    @IBAction func onViewMessageList(sender: AnyObject) {
        onViewMessageList()
    }
    
    func onLoad(){
        let time = NSDate().timeIntervalSinceNow
        let userName = "User-\(time)"

        if startMessagingFromOpenChat == true {
            let vc = MessagingTableViewController()
                vc.setViewMode(kMessagingViewMode)
                vc.initChannelTitle()
                vc.channelUrl = ""
                vc.userName   = userName
                vc.userId     = USER_ID
                vc.targetUserId = messagingTargetUserId
            
            navigationController?.pushViewController(vc, animated: false)
        }
        startMessagingFromOpenChat = true
    }
    
    func startMessagingWithUser(obj:NSNotification){
        messagingTargetUserId = obj.userInfo!["userId"] as! String
        
        startMessagingFromOpenChat = true
    }
    
    func startOpenChat(){
        let time = NSDate().timeIntervalSinceNow
        let userName = "User-\(time)"
        
        chattingVC = ChattingTableViewController()
        chattingVC!.setViewMode(kChannelListViewMode)
        chattingVC!.initChannelTitle()
        chattingVC!.userId     = USER_ID
        chattingVC!.userName   = messagingTargetUserId
        chattingVC!.channelUrl = channelURL
        navigationController?.pushViewController(chattingVC!, animated: false)
    }
    
    func startMessage(){
        let time = NSDate().timeIntervalSinceNow
        let userName = "User-\(time)"

        messagingVC = MessagingTableViewController()
        messagingVC?.setViewMode(kMessagingMemberViewMode)
        messagingVC?.initChannelTitle()
        messagingVC?.userId     = USER_ID
        messagingVC?.userName   = userName
        messagingVC?.channelUrl = channelURL
        navigationController?.pushViewController(messagingVC!, animated: false)
    }
    
    func onViewMessageList(){
        let time = NSDate().timeIntervalSinceNow
        let userName    = "User-\(time)"

        chattingVC = ChattingTableViewController()
        chattingVC!.setViewMode(kMessagingChannelListViewMode)
        chattingVC!.initChannelTitle()
        chattingVC!.userId     = USER_ID
        chattingVC!.userName   = userName
        chattingVC!.channelUrl = channelURL

        navigationController?.pushViewController(chattingVC!, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("startMessagingWithUser:"), name: "open_messaging", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        onLoad()
    }
}
