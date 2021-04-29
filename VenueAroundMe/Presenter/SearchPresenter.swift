import Combine
import CoreLocation
import UIKit

protocol SearchPresenterDelegate: AnyObject {
    func showPermission()
}

class SearchPresenter {
    // MARK: - Private properties
    private var locationManager: LocationDefinition
    private let networkManager: NetworkDefinition
    private weak var view: SearchView?
    private weak var delegate: SearchPresenterDelegate?

    private var bag = Set<AnyCancellable>()

    // MARK: - Init
    init(
        locationManager: LocationDefinition,
        networkManager: NetworkDefinition,
        view: SearchView?,
        delegate: SearchPresenterDelegate?
    ) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.view = view
        self.delegate = delegate
    }

    // MARK: - Public methods
    func viewDidLoad() {
        locationManager.delegate = self
    }

    func userDidSearch(with keyword: String) {
        guard let location = locationManager.currentUserLocation else { return }

        view?.showLoading()

        networkManager.getVenues(for: location.coordinate, keyword: keyword) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.view?.showError(error.localizedDescription)
            case let .success(foursquareResponse):
                guard let venues = foursquareResponse.response?.venues else {
                    self?.view?.showEmpty()
                    return
                }
                if venues.isEmpty {
                    self?.view?.showEmpty()
                } else {
                    self?.view?.showResult(venues)
                }
            }
        }
    }
}

extension SearchPresenter: LocationManagerDelegate {
    func didGetNewPermissionStatus(_ status: CLAuthorizationStatus) {
        locationManager.shouldStartSearching ? () : delegate?.showPermission()
    }
}
