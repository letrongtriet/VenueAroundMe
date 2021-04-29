import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didGetNewPermissionStatus(_ status: CLAuthorizationStatus)
}

class LocationManager: NSObject, LocationDefinition {
    private var manager: CLLocationManager
    var delegate: LocationManagerDelegate?

    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }

    var shouldAskForLocationPermission: Bool {
        manager.authorizationStatus == .notDetermined
    }

    var shouldStartSearching: Bool {
        switch manager.authorizationStatus {
        case .notDetermined:
            return false
        case .restricted:
            return false
        case .denied:
            return false
        case .authorizedAlways:
            return true
        case .authorizedWhenInUse:
            return true
        @unknown default:
            return false
        }
    }

    var currentUserLocation: CLLocation? {
        manager.location
    }

    func askForLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didGetNewPermissionStatus(status)
    }
}
