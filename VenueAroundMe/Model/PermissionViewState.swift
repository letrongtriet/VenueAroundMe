import UIKit

enum PermissionViewState {
    case notDetermined
    case restricted
}

extension PermissionViewState {
    var title: String {
        switch self {
        case .notDetermined:
            return "Hey, looks like you did not give us the persmisison for location."
        case .restricted:
            return """
            🥲 looks like you denied the permission. Please grant the permission following these steps:

            1. Go to Settings
            2. Go to Privacy
            3. Go to Location Services
            4. Go to VenueAroundMe
            """
        }
    }

    var buttonTitle: String {
        switch self {
        case .notDetermined:
            return "Let's go!"
        case .restricted:
            return "Go to Settings"
        }
    }
}
