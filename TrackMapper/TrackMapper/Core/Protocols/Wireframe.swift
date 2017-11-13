//
//  Wireframe.swift
//  Droppit
//
//  Created by Amador Navarro on 18/10/2017.
//  Copyright © 2017 Amador Navarro. All rights reserved.
//

import Foundation

protocol WireFrame {
    
    associatedtype PresenterController
    
    func setup(withPresenter presenter: PresenterController)
    
}
