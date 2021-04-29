import Combine
import CoreLocation
import Foundation

protocol NetworkDefinition {
    func getVenues(for coordinate: CLLocationCoordinate2D, keyword: String, completion: @escaping (Result<FoursquareResponse, APIError>) -> Void)
}
