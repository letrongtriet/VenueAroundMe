import UIKit

protocol PermissionCoordinatorDelegate: AnyObject {
    func showRootView()
}

class PermissionCoordinator {
    // MARK: - Private properties
    private let window: UIWindow
    private let locationManager: LocationDefinition
    private var delegate: PermissionCoordinatorDelegate?

    // MARK: - Init
    init(
        window: UIWindow,
        locationManager: LocationDefinition,
        delegate: PermissionCoordinatorDelegate?
    ) {
        self.window = window
        self.locationManager = locationManager
        self.delegate = delegate
    }

    // MARK: - Private methods
    private func showPermissionViewController() {
        let permissionViewController = PermissionViewController(nibName: "PermissionViewController", bundle: nil)
        let presenter = PermissionPresenter(
            locationManager: locationManager,
            view: permissionViewController,
            delegate: self
        )
        permissionViewController.presenter = presenter

        window.rootViewController = permissionViewController
        window.makeKeyAndVisible()
    }
}

// MARK: - Coordinator
extension PermissionCoordinator: Coordinator {
    func start() {
        showPermissionViewController()
    }
}

extension PermissionCoordinator: PermissionPresenterDelegate {
    func permissionGranted() {
        delegate?.showRootView()
    }
}
