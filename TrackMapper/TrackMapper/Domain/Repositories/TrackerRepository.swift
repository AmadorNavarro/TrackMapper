//
//  TrackerRepository.swift
//  TrackMapper
//
//  Created by BeRepublic on 11/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import RxSwift

protocol TrackerRepository {
    
    func addJourney(with journey: JourneyEntity) -> Completable
    
    func journeysList() -> Single<[JourneyEntity]>
    
}
