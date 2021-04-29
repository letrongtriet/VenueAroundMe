@testable import VenueAroundMe
import CoreLocation
import XCTest

class LocationDefinitionTests: XCTestCase {
    private let mockLocation = MockLocation()

    func testShouldStartSearching() {
        XCTAssert(mockLocation.shouldStartSearching == false)
    }

    func testShouldAskForLocationPermission() {
        XCTAssert(mockLocation.shouldAskForLocationPermission == true)
    }

    func testDelegate() {
        XCTAssertNil(mockLocation.delegate)
    }

    func testCurrUserLocation() {
        mockLocation.currentUserLocation = .init()
        XCTAssertNotNil(mockLocation.currentUserLocation)
    }

    func testAskForLocationPermission() {
        mockLocation.askForLocationPermission()
    }
}

private class MockLocation: LocationDefinition {
    var shouldStartSearching: Bool {
        false
    }

    var shouldAskForLocationPermission: Bool {
        true
    }

    var delegate: LocationManagerDelegate?

    var currentUserLocation: CLLocation?

    func askForLocationPermission() {
        XCTAssert(true)
    }
}
