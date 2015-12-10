//
//  ViewController.swift
//  MyMapbox
//
//  Created by Tommy Trojan on 10/5/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView!
    
    @IBOutlet weak var mapCanvas: UIView!
    
    func initMap(){
        // initialize the map view
        mapView = MGLMapView(frame: mapCanvas.bounds)
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // set the map's center coordinate
        mapView.setCenterCoordinate(CLLocationCoordinate2D(
            latitude: 38.894368,
            longitude: -77.036487),
            zoomLevel: 15,
            animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    func initPoint(){
        // Declare the annotation `point` and set its coordinates, title, and subtitle
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 38.894368, longitude: -77.036487)
        point.title = "Hello world!"
        point.subtitle = "Welcome to The Ellipse."
        
        // Add annotation `point` to the map
        mapView.addAnnotation(point)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initMap()
        initPoint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

