//
//  CoordinateDateMapper.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreData

final class CoordinateDataMapper: BaseEntityDataMapper<TrackerLocation, Coordinate>, BaseDataMapper {
    
    func transform(entity: Coordinate?) -> TrackerLocation {
        var location = TrackerLocation()
        if let entity = entity {
            location.position = entity.position?.intValue ?? 0
            location.latitude = entity.latitude?.doubleValue ?? 0.0
            location.longitude = entity.longitude?.doubleValue ?? 0.0
        }
        return location
    }
    
    func inverseTransform(domain: TrackerLocation?) -> Coordinate {
        return Coordinate()
    }
    
    func transform(entityList: [Coordinate]?) -> [TrackerLocation] {
        guard let entityList = entityList else { return [] }
        
        return entityList.map{ self.transform(entity: $0)}
    }
    
}
