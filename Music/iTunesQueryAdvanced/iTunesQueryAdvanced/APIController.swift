//
//  APIController.swift
//  iTunesQueryAdvanced
//
//  Created by tommy trojan on 5/20/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController{
    
    var delegate: APIControllerProtocol?
    
    func searchItunesFor(searchTerm: String, searchCategory: String) {
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly        
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=\(searchCategory)"
            let url = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                print("\(escapedSearchTerm) query complete.")
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    print(error!.localizedDescription)
                }
                var err: NSError?
                
                let jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    print("JSON Error \(err!.localizedDescription)")
                }
                //Trigger the delegate once the data has been parsed
                if let results: NSArray = jsonResult["results"] as? NSArray {
                    self.delegate?.didReceiveAPIResults(results)
                }
            })
            task.resume()
        }
    }
}

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

