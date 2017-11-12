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
import Action

final class MapViewModel: BaseViewModel {
    
    let switchTitle = BehaviorSubject(value: "Grabar ruta")
    let addJourneyUseCase = AddJourneyUseCaseImpl()
    let getJourneyUseCase = GetJourneysListUseCaseImpl()
    let journeysListAction = CocoaAction { return .empty() }
    let drawPathAction: Action<[CLLocationCoordinate2D], [CLLocationCoordinate2D]> = Action { element in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    var journeys: [JourneyModel] = []
    var coordinatesList: [CLLocationCoordinate2D] = []
    var startDate = Date()
    
    func numberOfRows() -> Int {
        return journeys.count
    }
    
    func cellViewModelAt(_ indexPath: IndexPath) -> JourneyCellViewModel {
        let viewModel = JourneyCellViewModel()
        let journey = journeys[indexPath.row]
        viewModel.setup(startTitle: journey.startDate, endTitle: journey.endDate)
        return viewModel
    }
    
    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return JourneyCell.preferredHeight
    }
    
    func sendJourney() {
        guard !coordinatesList.isEmpty else { return }
        
        _ = addJourneyUseCase.execute(with: startDate, endDate: Date(), coordinates: coordinatesList)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed():
                    break
                case .error(let error):
                    print("error trying to add journey: \(error)")
                }
            }.disposed(by: disposeBag)
    }
    
    func updatedJourneysList() {
        _ = getJourneyUseCase.execute()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let journeysList):
                    self.journeys = journeysList
                    self.reloadAction.execute()
                case .error(let error):
                    print("error trying to get journey: \(error)")
                }
            }.disposed(by: disposeBag)
        
    }
    
    func addCoordinate(_ locations: [CLLocationCoordinate2D]) {
        coordinatesList.append(contentsOf: locations)
        drawPathAction.execute(coordinatesList)
    }
    
    func initJourney() {
        startDate = Date()
        coordinatesList.removeAll()
    }
    
}
