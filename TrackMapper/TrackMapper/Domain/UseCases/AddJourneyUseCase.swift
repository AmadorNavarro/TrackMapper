//
//  AddJourneyUseCase.swift
//  TrackMapper
//
//  Created by BeRepublic on 11/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol AddJourneyUseCase {
    
    func execute(with startDate: Date, endDate: Date, coordinates: [CLLocationCoordinate2D]) -> Completable
    
}
