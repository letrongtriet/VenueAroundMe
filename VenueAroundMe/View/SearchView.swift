import UIKit

protocol SearchView: AnyObject {
    func showLoading()
    func showEmpty()
    func showError(_ message: String)
    func showResult(_ venues: [Venue])
}
