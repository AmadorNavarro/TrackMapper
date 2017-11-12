//
//  Date+Utils.swift
//  Droppit
//
//  Created by BeRepublic on 18/10/2017.
//  Copyright © 2017 BeRepublic. All rights reserved.
//

import Foundation

extension Date {
    
    func dayTimeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, HH:mm"
        return dateFormatter.string(from: self)
    }
    
}
