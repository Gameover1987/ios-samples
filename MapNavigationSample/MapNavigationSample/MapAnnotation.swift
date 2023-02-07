
import Foundation
import MapKit

final class MapAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var title: String? {
        if isDeviceLocation {
            return "Ваше местоположение"
        }
        
        return ""
    }
    
    let isDeviceLocation : Bool
    
    init(coordinate: CLLocationCoordinate2D, isDeviceLocation: Bool) {
        self.coordinate = coordinate
        
        self.isDeviceLocation = isDeviceLocation
    }
}
