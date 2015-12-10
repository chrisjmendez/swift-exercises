//
//  ViewController.swift
//  MyArcGIS
//
//  Created by Tommy Trojan on 10/5/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController {

    var map:AGSMap!
    
    @IBOutlet weak var mapView: AGSMapView!
    
    func initMap(){
        /*
        .Imagery
        .ImageryWithLabels
        .Streets
        .Topographic
        .TerrainWithLabels
        .LightGrayCanvas
        .NationalGeographic
        .Oceans
        .Unknown
        */
        
        //Display a map using the ArcGIS Online imagery basemap service
        self.mapView.map = AGSMap(basemapType: .Streets,
            latitude: 34.056295,
            longitude: -117.195800,
            levelOfDetail: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
