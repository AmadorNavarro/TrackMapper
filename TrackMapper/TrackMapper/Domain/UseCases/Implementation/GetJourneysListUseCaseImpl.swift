//
//  GetJourneysListUseCaseImpl.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import RxSwift

final class GetJourneysListUseCaseImpl: BaseUseCaseImpl<TrackerRepository>, GetJourneysListUseCase {
    
    init() {
        super.init(repository: TrackerRepositoryImpl())
    }
    
    func execute() -> Single<[JourneyModel]> {
        return repository.journeysList().map { journeyEntities -> [JourneyModel] in
            return JourneyModelDataMapper().transform(entityList: journeyEntities)
        }
    }
    
}
