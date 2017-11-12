//
//  CoordinateModelDataMapper.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation

final class CoordinateModelDataMapper: BaseModelDataMapper<CLLocationCoordinate2D, TrackerLocation>, BaseDataMapper {
    
    func transform(entity: TrackerLocation?) -> CLLocationCoordinate2D {
        var location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        if let entity = entity {
            location.latitude = entity.latitude
            location.longitude = entity.longitude
        }
        return location
    }
    
    func inverseTransform(domain: CLLocationCoordinate2D?) -> TrackerLocation {
        var location = TrackerLocation()
        if let domain = domain {
            location.latitude = domain.latitude
            location.longitude = domain.longitude
        }
        return location
    }
    
    func transform(entityList: [TrackerLocation]?) -> [CLLocationCoordinate2D] {
        var locationList: [CLLocationCoordinate2D] = []
        if let entity = entityList {
            for location in entity {
                locationList.append(self.transform(entity: location))
            }
        }
        return locationList
    }
    
    func inverseTransform(domainList: [CLLocationCoordinate2D]?) -> [TrackerLocation] {
        var locationList: [TrackerLocation] = []
        if let entity = domainList {
            for (index, location) in entity.enumerated() {
                var trakerLocation = self.inverseTransform(domain: location)
                trakerLocation.position = index
                locationList.append(trakerLocation)
            }
        }
        return locationList
    }
    
}
