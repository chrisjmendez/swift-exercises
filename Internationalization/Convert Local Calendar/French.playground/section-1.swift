import UIKit

class Calendar{
    //Array of strings that are the names of months in French
    //NSDate is used but you can't assign value in a single line
    //Instead, assign the property to the result of an inline function
    var frenchMonths: [String] = {
        println("Calculating French months...")
        
        let df = NSDateFormatter()
        //Set locale to French
        df.locale = NSLocale(localeIdentifier: "fr_FR")
        //Access months symbols property, downcast the values to strings
        return df.monthSymbols.map() { $0 as! String }
    //Invoke the anonymous function
    }()
}

let cal = Calendar()
    cal.frenchMonths