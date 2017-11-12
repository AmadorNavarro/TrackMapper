//
//  JourneyDataMapper.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation

final class JourneyDataMapper: BaseModelDataMapper<JourneyEntity,Journey>, BaseDataMapper {
    
    func transform(entity: Journey?) -> JourneyEntity {
        var journeyEntity = JourneyEntity()
        if let entity = entity {
            journeyEntity.startDate = entity.start ?? Date()
            journeyEntity.endDate = entity.end ?? Date()
            journeyEntity.locations = CoordinateDataMapper().transform(entityList: entity.coordinatesList())
        }
        return journeyEntity
    }
    
    func inverseTransform(domain: JourneyEntity?) -> Journey {
        return Journey()
    }
    
    func transform(entityList: [Journey]?) -> [JourneyEntity] {
        guard let entityList = entityList else { return [] }
        
        return entityList.map{ self.transform(entity: $0) }
    }

}
