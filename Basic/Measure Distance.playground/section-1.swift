// Playground - noun: a place where people can play

import UIKit

class Distance{
    let FEET_PER_METERS = 3.28084
    
    var meters: Double = 0
    
    var feet:Double{
        get{
            return self.meters * FEET_PER_METERS
        }
        set{
            self.meters = newValue / FEET_PER_METERS
        }
    }
    
    init(meters:Double){
        self.meters = meters
    }
}

let dist = Distance(meters: 34)
dist.meters
dist.feet
dist.feet = 102
dist.meters

