import CoreLocation
import UIKit

protocol PermissionPresenterDelegate: AnyObject {
    func permissionGranted()
}

class PermissionPresenter {
    // MARK: - Private properties
    private var locationManager: LocationDefinition
    private weak var view: PermissionView?
    private weak var delegate: PermissionPresenterDelegate?

    // MARK: - Init
    init(
        locationManager: LocationDefinition,
        view: PermissionView?,
        delegate: PermissionPresenterDelegate?
    ) {
        self.locationManager = locationManager
        self.view = view
        self.delegate = delegate
    }

    // MARK: - Public methods
    func viewDidLoad() {
        let state: PermissionViewState = locationManager.shouldAskForLocationPermission ? .notDetermined : .restricted
        view?.updateView(with: state)
    }

    func userDidTapGrantPermissionButton() {
        locationManager.shouldAskForLocationPermission ? askForPermission() : showAppSettings()
    }

    // MARK: - Private methods
    private func showAppSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        locationManager.delegate = self
    }

    private func askForPermission() {
        locationManager.askForLocationPermission()
        locationManager.delegate = self
    }

    private func newPermissionStatus(_ status: CLAuthorizationStatus) {
        let state: PermissionViewState = locationManager.shouldStartSearching ? .notDetermined : .restricted
        view?.updateView(with: state)

        if locationManager.shouldStartSearching {
            locationManager.delegate = nil
            delegate?.permissionGranted()
        }
    }
}

extension PermissionPresenter: LocationManagerDelegate {
    func didGetNewPermissionStatus(_ status: CLAuthorizationStatus) {
        newPermissionStatus(status)
    }
}
