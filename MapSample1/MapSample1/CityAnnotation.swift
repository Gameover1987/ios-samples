
import Foundation
import MapKit

final class CapitalAnnotation : NSObject, MKAnnotation {
    var title: String?
    
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, info: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = info
        self.coordinate = coordinate
        
        super.init()
    }
}

extension CapitalAnnotation {
    static func make() -> [CapitalAnnotation] {
        return [
            CapitalAnnotation(
                title: "London",
                info: "Is the capital of Britain",
                coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
            CapitalAnnotation(
                title: "Novosibirsk",
                info: "Is the capital of world",
                coordinate: CLLocationCoordinate2D(latitude: 55.0162334, longitude: 82.9457969))
        ]
    }
}
