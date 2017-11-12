//
//  TrackerLocation.swift
//  TrackMapper
//
//  Created by BeRepublic on 11/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation

struct TrackerLocation {
    
    var position: Int = 0
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    init(position: Int = 0, latitude: CLLocationDegrees = 0.0, longitude: CLLocationDegrees = 0.0) {
        self.position = position
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
