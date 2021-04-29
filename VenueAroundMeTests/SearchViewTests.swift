@testable import VenueAroundMe
import XCTest

class SearchViewTests: XCTestCase {
    private let searchViewMock = SearchViewMock()

    func testShowLoading() {
        searchViewMock.showLoading()
        XCTAssert(searchViewMock.isLoading == true)
    }

    func testShowEmpty() {
        searchViewMock.showEmpty()
        XCTAssert(searchViewMock.isEmpty == true)
    }

    func testShowError() {
        searchViewMock.showError("Mock Error Message")
        XCTAssert(searchViewMock.errorMessage == "Mock Error Message")
    }

    func testShowResult() {
        searchViewMock.showResult([])
    }
}

private class SearchViewMock: SearchView {
    var isLoading = false
    var isEmpty = false
    var errorMessage = ""

    func showLoading() {
        isLoading = true
    }

    func showEmpty() {
        isEmpty = true
    }

    func showError(_ message: String) {
        errorMessage = message
    }

    func showResult(_ venues: [Venue]) {
        XCTAssert(venues.isEmpty)
    }
}
