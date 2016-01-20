//
//  ViewController.swift
//  GoogleDirectionAPI
//
//  Created by Chris on 1/18/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//
// Note:
// HOW to get your "Google Maps Directions API" Key: https://developers.google.com/maps/documentation/ios-sdk/start?hl=en
// Google Issues https://developers.google.com/places/web-service/faq#why_do_i_keep_receiving_status_request_denied

import UIKit
import CoreLocation
import PXGoogleDirections

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    let GOOGLE_API_KEY = "<insert your Google API key here>"
    
    var directionsAPI:PXGoogleDirections?

    func onLoad(){
        let coords = CLLocationCoordinate2D(latitude: 37.331690, longitude: -122.030762)
        let name = "Googleplex Mountain View United States"
        
        directionsAPI = PXGoogleDirections(apiKey: GOOGLE_API_KEY)
        directionsAPI?.from = PXLocation.CoordinateLocation(coords)
        directionsAPI?.to   = PXLocation.NamedLocation(name)
        directionsAPI?.calculateDirections(onDirectionsCompleteHandler)
    }
    
    func onDirectionsCompleteHandler(response:PXGoogleDirectionsResponse){
        switch response {
            case let .Error(_, error):
                // Oops, something bad happened, see the error object for more information
                print(error.userInfo.description)
                break
            case let .Success(request, routes):
                // Do your work with the routes object array here
                textView.text = ""
                for step:PXGoogleDirectionsRouteLegStep in routes[0].legs[0].steps {
                    textView.text.appendContentsOf("\(step.htmlInstructions!)\n\n")
                }
                
                break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

