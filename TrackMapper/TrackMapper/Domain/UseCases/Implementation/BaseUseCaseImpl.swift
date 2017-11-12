//
//  BaseUseCaseImpl.swift
//  Droppit
//
//  Created by BeRepublic on 18/10/2017.
//  Copyright © 2017 opentrends. All rights reserved.
//

import Foundation

/** Base class to initialize the repository
    - parameters:
        - T: The parameter type of the repository
    */
class BaseUseCaseImpl<T> {
    
    internal let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
    
}
