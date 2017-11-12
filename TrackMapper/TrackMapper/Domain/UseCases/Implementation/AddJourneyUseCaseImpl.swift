//
//  AddJourneyUseCaseImpl.swift
//  TrackMapper
//
//  Created by BeRepublic on 11/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

final class AddJourneyUseCaseImpl: BaseUseCaseImpl<TrackerRepository>, AddJourneyUseCase {
    
    init() {
        super.init(repository: TrackerRepositoryImpl())
    }
    
    func execute(with startDate: Date, endDate: Date, coordinates: [CLLocationCoordinate2D]) -> Completable {
        return repository.addJourney(with: JourneyEntity(startDate: startDate, endDate: endDate, locations: CoordinateModelDataMapper().inverseTransform(domainList: coordinates)))
    }
    
}
