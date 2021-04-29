@testable import VenueAroundMe
import XCTest

class VenueCellViewTest: XCTestCase {
    func testUpdateView() {
        let venueCellViewMock = VenueCellViewMock()
        venueCellViewMock.updateView(with: venueCellViewMock.venue)
    }
}

private class VenueCellViewMock: VenueCellView {
    let venue = Venue(id: nil, name: "Name", location: nil)

    func updateView(with venue: Venue) {
        XCTAssert(self.venue == venue)
    }
}
