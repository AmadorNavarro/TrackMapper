import Foundation
import CoreData

@objc(Journey)
open class Journey: _Journey {
	
    class func journey(with startDate: Date, endDate: Date, coordinatesList: [Coordinate], context: NSManagedObjectContext) -> Journey {
        let journey = Journey(context: context)
        journey.start = startDate
        journey.end = endDate
        journey.coordinates = NSSet(array: coordinatesList)
        return journey
    }
    
    func coordinatesList() -> [Coordinate] {
        if let list = coordinates.allObjects as? [Coordinate] {
            return list.sorted { $0.position?.intValue ?? 0 < $1.position?.intValue ?? 0 }
        }
        return []
    }
    
}
