//
//  JourneyModelDataMapper.swift
//  TrackMapper
//
//  Created by BeRepublic on 11/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation

final class JourneyModelDataMapper: BaseModelDataMapper<JourneyModel,JourneyEntity>, BaseDataMapper {
    
    func transform(entity: JourneyEntity?) -> JourneyModel {
        var journey = JourneyModel()
        if let entity = entity {
            journey.startDate = entity.startDate.dayTimeToString()
            journey.endDate = entity.endDate.dayTimeToString()
            journey.locations = CoordinateModelDataMapper().transform(entityList: entity.locations)
        }
        return journey
    }
    
    func inverseTransform(domain model: JourneyModel?) -> JourneyEntity {
        var journey = JourneyEntity()
        if let model = model {
            journey.startDate = model.startDate.dateStringToTime()
            journey.endDate = model.endDate.dateStringToTime()
            journey.locations = CoordinateModelDataMapper().inverseTransform(domainList: model.locations)
        }
        return journey
    }
    
}
