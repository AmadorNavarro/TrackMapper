//
//  BaseEntityDataMapper.swift
//  Droppit
//
//  Created by BeRepublic on 18/10/2017.
//  Copyright © 2017 BeRepublic. All rights reserved.
//

import Foundation

/** Class that implement the Protocol to transform the classes.
    - parameters:
        - T: The parameter type out for the class
        - E: The parameter type in for the class
    */
class BaseModelDataMapper<T,E>: BaseGenericDataMapper {
    
    typealias InData = E
    typealias OutData = T
    
}
