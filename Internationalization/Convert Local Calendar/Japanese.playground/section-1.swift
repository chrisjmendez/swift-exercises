import UIKit

class Calendar{
    var japaneseMonths: [String]
    
    init(){
        let df = NSDateFormatter()
        //Set locale to French
        df.locale = NSLocale(localeIdentifier: "ja_JP")
        //Access months symbols property, downcast the values to strings
        self.japaneseMonths = df.monthSymbols.map() { $0 as! String }
    }
    
}

let cal = Calendar()
cal.japaneseMonths
