
import UIKit
import MapKit

class ViewController: UIViewController {

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .hybrid
        
        let initialLocation = CLLocationCoordinate2D(latitude: 55.0162334, longitude: 82.9457969)
        
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setCenter(initialLocation, animated: true)
        mapView.setRegion(region, animated: true)
        
       
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "MapKit sample"
        
        view.addSubview(mapView)
        
        let annotations = CapitalAnnotation.make()
        mapView.addAnnotations(annotations)
        
        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }


}

