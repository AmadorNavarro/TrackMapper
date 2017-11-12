//
//  GetJourneysListUseCase.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol GetJourneysListUseCase {
    
    func execute() -> Single<[JourneyModel]>
    
}
