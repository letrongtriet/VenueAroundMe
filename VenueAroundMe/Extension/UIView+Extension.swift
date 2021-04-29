import UIKit

extension UIView {
    func showLoadingIndicator() {
        let containerView = UIView(frame: bounds)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        containerView.tag = 0xDEADBEEF
        containerView.layer.cornerRadius = layer.cornerRadius

        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.startAnimating()

        containerView.addSubview(loadingIndicator)
        loadingIndicator.center = containerView.center
        addSubview(containerView)
        bringSubviewToFront(containerView)
    }

    func hideLoadingIndicator() {
        if let foundView = viewWithTag(0xDEADBEEF) {
            foundView.removeFromSuperview()
        }
    }
}
