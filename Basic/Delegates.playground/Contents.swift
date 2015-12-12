//: Playground - noun: a place where people can play
//: Source: http://stackoverflow.com/questions/25395000/sharing-data-between-classes-via-delegates-in-swift-ios

import UIKit

// Protocol to send message between classes.
protocol SendersMessageDelegate{
    func shareMessage(message: NSString)
}

// Class that sends the message
class Sender{
    
    // Create variable to hold message
    var sendersMessage: NSString = NSString()
    
    var delegate: SendersMessageDelegate?
    
    // Save the message that it needs to send
    init(sendersMessage: NSString){
        self.sendersMessage = sendersMessage
    }
    
    // If it has as a delegate, then share the message with it.
    func sendMessage() {
        delegate?.shareMessage(sendersMessage)
    }
}

//Class receiving the message
class Receiver: SendersMessageDelegate{
    
    var savedMessage:NSString?
    
    func shareMessage(message: NSString) {
        savedMessage = message
        print(message)
    }
}

//Create Sender and Receiver
var sender: Sender = Sender(sendersMessage: "Hello Receiver.")
var receiver: Receiver = Receiver()

//give Sender it's Receiver
sender.delegate = receiver

//Trigger the sender to send message to it's Receiver
sender.sendMessage()
