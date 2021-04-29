import UIKit

class PermissionViewController: UIViewController {
    // MARK: - Dependencies
    var presenter: PermissionPresenter!

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var permissionButton: UIButton!

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        permissionButton.layer.cornerRadius = 8
        permissionButton.layer.masksToBounds = true
    }

    // MARK: - Private methods
    @IBAction
    private func buttonPressed(_ sender: Any) {
        presenter.userDidTapGrantPermissionButton()
    }
}

extension PermissionViewController: PermissionView {
    func updateView(with state: PermissionViewState) {
        titleLabel.text = state.title
        permissionButton.setTitle(state.buttonTitle, for: .normal)
    }
}
