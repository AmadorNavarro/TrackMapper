//
//  MapViewModel.swift
//  TrackMapper
//
//  Created by BeRepublic on 10/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import RxSwift

final class MapViewModel: BaseViewModel {
    
    let switchOnState = BehaviorSubject(value: false)
    let switchTitle = BehaviorSubject(value: "Seguir ruta")
    
    func changeSwitchState(_ newState: Bool) {
        switchOnState.onNext(newState)
    }
    
}
