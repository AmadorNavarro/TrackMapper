//
//  JourneyEntity.swift
//  TrackMapper
//
//  Created by BeRepublic on 11/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation

struct JourneyEntity {
    
    var startDate = Date()
    var endDate = Date()
    var locations: [TrackerLocation] = []
    
}
