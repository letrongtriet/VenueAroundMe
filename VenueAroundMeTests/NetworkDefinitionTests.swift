@testable import VenueAroundMe
import CoreLocation
import XCTest

class NetworkDefinitionTests: XCTestCase {
    func testSuccessfulCall() {
        let failNetwork = FailNetwork()
        failNetwork.getVenues(for: .init(), keyword: "") { result in
            switch result {
            case let .failure(error):
                XCTAssert(error == APIError.noResponse)
            case .success:
                XCTFail()
            }
        }
    }

    func testFailedCall() {
        let failNetwork = SuccessNetwork()
        failNetwork.getVenues(for: .init(), keyword: "") { result in
            switch result {
            case .failure:
                XCTFail()
            case let .success(response):
                XCTAssert(response.response == nil)
            }
        }
    }
}

private class FailNetwork: NetworkDefinition {
    func getVenues(for coordinate: CLLocationCoordinate2D, keyword: String, completion: @escaping (Result<FoursquareResponse, APIError>) -> Void) {
        completion(.failure(.noResponse))
    }
}

private class SuccessNetwork: NetworkDefinition {
    func getVenues(for coordinate: CLLocationCoordinate2D, keyword: String, completion: @escaping (Result<FoursquareResponse, APIError>) -> Void) {
        completion(.success(.init(response: nil)))
    }
}
