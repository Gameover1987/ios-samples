
import SnapKit
import CoreLocation
import MapKit

final class MapNavigationViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    
    private var startLocation: MapAnnotation?
    private var endLocation: MapAnnotation?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapLongPressed))
        mapView.addGestureRecognizer(longPressRecognizer)
        
        locationManager.delegate = self
        
        mapView.delegate = self
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mapView.addGestureRecognizer(longPressRecognizer)
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func mapLongPressed(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: mapView)
        
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        print("Long press at \(coordinate)")
        
        let annotation = MapAnnotation(coordinate: coordinate, isDeviceLocation: false)
        mapView.addAnnotations([annotation])
        
        endLocation = annotation
        
        guard let startCoordinate = startLocation?.coordinate else {return}
        guard let endCoordinate = endLocation?.coordinate else {return}
        
        mapView.removeOverlays(mapView.overlays)
        
        let coordinates = [startCoordinate, endCoordinate]
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            guard let response = response else { return }
            
            if (response.routes.count > 0) {
                self.mapView.addOverlay(response.routes[0].polyline)
                self.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
    }
}

extension MapNavigationViewController : CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            
            locationManager.startUpdatingLocation()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {return}
        
        let latLonMeters = 10000.0
        
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: latLonMeters, longitudinalMeters: latLonMeters)
        
        mapView.setCenter(currentLocation.coordinate, animated: true)
        mapView.setRegion(region, animated: true)
        
        let mapAnnotaion = MapAnnotation(coordinate: currentLocation.coordinate, isDeviceLocation: true)
        
        print(currentLocation.coordinate)
        
        self.mapView.removeAnnotation(mapAnnotaion)
        
        mapView.addAnnotations([mapAnnotaion])
        
        startLocation = mapAnnotaion
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapNavigationViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .systemBlue
        polylineRenderer.lineWidth = 5
        
        return polylineRenderer
        
    }
}
