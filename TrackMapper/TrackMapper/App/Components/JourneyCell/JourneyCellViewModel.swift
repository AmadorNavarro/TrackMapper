//
//  JourneyCellViewModel.swift
//  TrackMapper
//
//  Created by BeRepublic on 12/11/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation
import RxSwift

final class JourneyCellViewModel {
    
    let startTitle = BehaviorSubject(value: "")
    let endTitle = BehaviorSubject(value: "")
    
    func setup(startTitle: String, endTitle: String) {
        self.startTitle.onNext(startTitle)
        self.endTitle.onNext(endTitle)
    }
    
}
