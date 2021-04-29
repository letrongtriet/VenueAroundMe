import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light

        let locationManager = LocationManager()
        let networkManager = NetworkManager(baseUrlString: Constants.Endpoint.baseUrlString)

        appCoordinator = AppCoordinator(
            window: window!,
            locationManager: locationManager,
            networkManager: networkManager
        )
        appCoordinator.start()

        return true
    }
}
