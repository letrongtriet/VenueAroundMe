import Combine
import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func showPermission()
}

class SearchCoordinator {
    // MARK: - Private properties
    private let window: UIWindow
    private let locationManager: LocationDefinition
    private let networkManager: NetworkDefinition
    private let navigationController: UINavigationController
    private weak var delegate: SearchCoordinatorDelegate?

    // MARK: - Init
    init(
        window: UIWindow,
        locationManager: LocationDefinition,
        networkManager: NetworkDefinition,
        delegate: SearchCoordinatorDelegate?
    ) {
        self.window = window
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.delegate = delegate

        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Coordinator
extension SearchCoordinator: Coordinator {
    func start() {
        let searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let presenter = SearchPresenter(
            locationManager: locationManager,
            networkManager: networkManager,
            view: searchViewController,
            delegate: self
        )
        searchViewController.presenter = presenter

        navigationController.setViewControllers([searchViewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension SearchCoordinator: SearchPresenterDelegate {
    func showPermission() {
        delegate?.showPermission()
    }
}
