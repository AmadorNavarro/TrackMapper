import Foundation
import CoreData

@objc(Coordinate)
open class Coordinate: _Coordinate {
	
    open class func coordinate(with position: Int, latitude: Double, longitud: Double, context: NSManagedObjectContext) -> Coordinate {
        let coordinate = Coordinate(context: context)
        coordinate.position = NSNumber(integerLiteral: position)
        coordinate.latitude = NSNumber(floatLiteral: latitude)
        coordinate.longitude = NSNumber(floatLiteral: longitud)
        return coordinate
    }
    
}
