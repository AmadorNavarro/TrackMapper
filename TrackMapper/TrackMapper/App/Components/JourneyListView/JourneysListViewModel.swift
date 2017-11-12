//
//  JourneysListViewModel.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import RxSwift
import Action

final class JourneysListViewModel {
    
    let buttonTitle = BehaviorSubject(value: "Listado de rutas")
    var buttonAction = CocoaAction { return .empty() }
    
    func setup(buttonAction: CocoaAction) {
        self.buttonAction = buttonAction
    }
    
}
