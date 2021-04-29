import UIKit

protocol PermissionView: AnyObject {
    func updateView(with state: PermissionViewState)
}
