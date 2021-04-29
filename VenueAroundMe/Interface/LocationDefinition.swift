import CoreLocation
import Foundation

protocol LocationDefinition {
    var shouldStartSearching: Bool { get }
    var shouldAskForLocationPermission: Bool { get }
    var delegate: LocationManagerDelegate? { get set }
    var currentUserLocation: CLLocation? { get }
    func askForLocationPermission()
}
