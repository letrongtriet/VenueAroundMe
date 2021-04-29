@testable import VenueAroundMe
import XCTest

class PermissionViewTests: XCTestCase {
    func testUpdateViewWithState() {
        let permissionViewMock = PermissionViewMock()
        permissionViewMock.updateView(with: .notDetermined)
    }
}

private class PermissionViewMock: PermissionView {
    func updateView(with state: PermissionViewState) {
        XCTAssert(state == .notDetermined)
    }
}
