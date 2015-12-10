import Foundation

let date = NSDate()
let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")

print(dateFormatter.stringFromDate(date))

