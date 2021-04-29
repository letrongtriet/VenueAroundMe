import UIKit

class SearchViewController: UIViewController {
    // MARK: - Dependencies
    var presenter: SearchPresenter!

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private properties
    private var venues = [Venue]()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        setup()
    }

    // MARK: - Private methods
    private func setup() {
        setupTableView()
        setupSearchBar()
    }

    private func setupTableView() {
        VenueTableViewCell.registerNib(in: tableView)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        view.endEditing(true)
        presenter.userDidSearch(with: text)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        venues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VenueTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateView(with: venues[indexPath.row])
        return cell
    }
}

extension SearchViewController: SearchView {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.restore()
            self?.tableView.showLoadingIndicator()
        }
    }

    func showEmpty() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.hideLoadingIndicator()
            self?.tableView.setEmptyMessage("There is no results for this keyword. Please try again with another keyword")
        }
    }

    func showError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.hideLoadingIndicator()
            self?.tableView.setEmptyMessage("Oooops! Something went wrong. Find out more below. \n\n \(message)")
        }
    }

    func showResult(_ venues: [Venue]) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.hideLoadingIndicator()
            self?.tableView.restore()
            self?.venues = venues
            self?.tableView.reloadDataAnimated()
        }
    }
}
