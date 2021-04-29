import CoreLocation
import UIKit

class AppCoordinator {
    // MARK: - Private properties
    private var searchCoordinator: SearchCoordinator?
    private var permissionCoordinator: PermissionCoordinator?

    private let window: UIWindow
    private let locationManager: LocationDefinition
    private let networkManager: NetworkDefinition

    // MARK: - Init
    init(
        window: UIWindow,
        locationManager: LocationDefinition,
        networkManager: NetworkDefinition
    ) {
        self.window = window
        self.locationManager = locationManager
        self.networkManager = networkManager
    }

    // MARK: - Private methods
    private func showSearchView() {
        searchCoordinator = SearchCoordinator(
            window: window,
            locationManager: locationManager,
            networkManager: networkManager,
            delegate: self
        )
        searchCoordinator?.start()
    }

    private func showPermissionView() {
        permissionCoordinator = PermissionCoordinator(
            window: window,
            locationManager: locationManager,
            delegate: self
        )
        permissionCoordinator?.start()
    }
}

// MARK: - Coordinator
extension AppCoordinator: Coordinator {
    func start() {
        locationManager.shouldStartSearching ? showSearchView() : showPermissionView()
    }
}

extension AppCoordinator: PermissionCoordinatorDelegate {
    func showRootView() {
        showSearchView()
    }
}

extension AppCoordinator: SearchCoordinatorDelegate {
    func showPermission() {
        showPermissionView()
    }
}
