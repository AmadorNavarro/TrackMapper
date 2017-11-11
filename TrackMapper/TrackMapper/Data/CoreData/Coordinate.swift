import Foundation
import CoreLocation

@objc(Coordinate)
open class Coordinate: _Coordinate {
	
    func coordinates() -> CLLocationCoordinate2D {
        let latitude: CLLocationDegrees = self.latitude?.doubleValue ?? 0.0
        let longitude: CLLocationDegrees = self.longitude?.doubleValue ?? 0.0
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
}
