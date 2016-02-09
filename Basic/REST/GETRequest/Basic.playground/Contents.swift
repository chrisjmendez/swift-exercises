//: Playground - noun: a place where people can play

import UIKit

class Test {
    
    init(path:String){
        getRequest(path)
    }
    
    func getRequest(path:String){
        let operationQueue:NSOperationQueue = {
            let operationQueue = NSOperationQueue()
                operationQueue.name = "com.chrisjmendez.queue"
                operationQueue.maxConcurrentOperationCount = 1
            return operationQueue
        }()

        //A. Craft a GET Request
        let url = NSURL(string: path)
        let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "GET"
        //B. Send a GET Reqest
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: operationQueue) { (response, responseData, error) -> Void in
            print("!", response)
            //C. Convert JSON to NSArray
            if error != nil {
                print("error", error?.localizedDescription)
            }
            if let data = responseData{
                print("data", data)
            }
        }
    }
    func parseResponse(json:NSArray){
        print(json)
    }
}

let test = Test(path: "http://geni.us/youcouldbemine")


extension String {
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    /// - returns: Return precent escaped string.
    func stringByReplacingSpaceWithPlusEncodingForQueryValue() -> String? {
        let term = self.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)

        // Anything which is not URL-friendly is escaped
        let escapedTerm = term.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        return escapedTerm
    }
}

extension Double {
    func toStringWithDecimalPlaces(numberOfDecimalPlaces:Int) -> String {
        return String(format:"%."+numberOfDecimalPlaces.description+"f", self)
    }
}
