//
//  TrackerRepositoryImpl.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

final class TrackerRepositoryImpl: TrackerRepository {
    
    private let model = DATAStack()
    private let context: NSManagedObjectContext!
    
    init() {
        context = model.mainContext
    }
    
    func addJourney(with journey: JourneyEntity) -> Completable {
        return Completable.create(subscribe: { [weak self] completable -> Disposable in
            guard let `self` = self else { return Disposables.create() }
            
            self.addJourneyToDataBase(journey)
            completable(.completed)
            return Disposables.create()
        })
    }
    
    func journeysList() -> Single<[JourneyEntity]> {
        return Single.just(requestJourneys()).map { journeys -> [JourneyEntity] in
            return JourneyDataMapper().transform(entityList: journeys)
        }
    }
    
    private func addJourneyToDataBase(_ journey: JourneyEntity) {
        var locationList: [Coordinate] = []
        for location in journey.locations {
            locationList.append(Coordinate.coordinate(with: location.position, latitude: location.latitude, longitud: location.longitude, context: context))
        }
        _ = Journey.journey(with: journey.startDate, endDate: journey.endDate, coordinatesList: locationList, context: context)
        do {
            _ = try context.save()
        } catch {
            print("context can't save new entities")
        }
    }
    
    private func requestJourneys() -> [Journey] {
        var journeys: [Journey] = []
        let fetchRequest = NSFetchRequest<Journey>(entityName: Journey.entityName())
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: JourneyAttributes.start.rawValue, ascending: true)]
        do {
            journeys = try context.fetch(fetchRequest)
        } catch {
            print("error executing fetchRequest: \(fetchRequest.description)")
        }
        return journeys
    }
    
}
