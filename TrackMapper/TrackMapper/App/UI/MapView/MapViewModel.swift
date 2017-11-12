//
//  MapViewModel.swift
//  TrackMapper
//
//  Created by BeRepublic on 10/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

final class MapViewModel: BaseViewModel {
    
    let switchTitle = BehaviorSubject(value: "Grabar ruta")
    let addJourneyUseCase = AddJourneyUseCaseImpl()
    var coordinatesList: [CLLocationCoordinate2D] = []
    var startDate = Date()
    
    func sendJourney() {
        guard !coordinatesList.isEmpty else { return }
        
        _ = addJourneyUseCase.execute(with: startDate, endDate: Date(), coordinates: coordinatesList)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed():
                    print("completed")
                    break
                case .error(let error):
                    print("error trying to add journey: \(error)")
                }
            }.disposed(by: disposeBag)
    }
    
    func addCoordinate(_ locations: [CLLocationCoordinate2D]) {
        coordinatesList.append(contentsOf: locations)
    }
    
    func initJourney() {
        startDate = Date()
        coordinatesList.removeAll()
    }
    
}
