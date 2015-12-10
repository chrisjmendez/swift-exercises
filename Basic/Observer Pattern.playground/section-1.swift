import UIKit

/*
There are two events fired for every property change, willSetEvent and didSetEvent
*/

class Person{
    var firstName:String{
        willSet{
            var message:String = "Changing firstName from \(firstName) to \(newValue)"
            var m = Messages()
                m.displayMessage(message)
        }
        didSet{
            println("Changed firstName from \(oldValue) to \(firstName)")
        }
    }
    
    var lastName:String{
        willSet(newLast){
            println("Changing lastName from \(firstName) to \(newLast)")
        }
        didSet(oldLast){
            println("Changed lastName from \(oldLast) to \(firstName)")
        }
    }
    
    init(firstName:String, lastName:String){
        self.firstName = firstName
        self.lastName  = lastName
    }
}


class Messages{
    var message:String = "";
    
    func displayMessage(message:String){
        println("changing name to \(message)")
    }
}

let p = Person(firstName: "Chris", lastName: "aiv")

p.firstName = "James";

//p.lastName = "Bob"

