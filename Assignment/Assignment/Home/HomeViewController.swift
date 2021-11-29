import UIKit

// MARK: Homeviewcontroller
final class HomeViewController: UIViewController {
    
    /// Public variables
    var presenter: HomePresenterInput?
    
    /// Private variables
    private let tableView = UITableView()
    
    /// Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// LifyCycles
    override func viewDidLoad() {
        view.backgroundColor = .white
        initializing()
    }
}

// MARK: HomePresenterOutput methods
extension HomeViewController: HomePresenterOutput {
    /// Update screen when get data
    /// - Parameter filterOn: check if filter applied or not
    func updateListOfLaunches(with filterOn: Bool) {
        addBarButton(filterOn: filterOn)
        tableView.reloadData()
        hideOverlayView()
    }
    
    /// Display error
    /// - Parameter error: error
    func handleFailure(with error: APIError) {
        hideOverlayView()
        let alert = UIAlertController(title: nil, message: error.customDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if (self.presentedViewController != nil) {
            dismiss(animated: true) {
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: Tableview datasource methods
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getLaunchDataCount() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = presenter?.getLaunchDataCount() ?? .zero
        if indexPath.row == count - 1 {
            /// Add spinner at the bottom of tableview
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            
        } else {
            if let launch = presenter?.getDocInfo(for: indexPath.row) {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: HomeTableViewCell.nameOfClass,
                    for: indexPath) as! HomeTableViewCell
                
                cell.update(label: launch.name, time: launch.dateUTC.changeDateFormattoDefault() ?? String())
                /// remove spinner at the bottom of tableview
                tableView.tableFooterView = UIView()
                tableView.tableFooterView?.isHidden = true
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: Tableview delegate methods
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedLaunch(for: indexPath.row, navController: self.navigationController!)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = presenter?.getLaunchDataCount() ?? .zero
        if indexPath.row == count - 1 {
            presenter?.loadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: Private methods
private extension HomeViewController {
    /// Initial setup
    func initializing() {
        showOverlay()
        presenter?.loadData()
        addBarButton(filterOn: false)
        configureTableView()
    }
    
    /// Tableview configuration
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        
        tableView.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.nameOfClass
        )
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    /// Add Loader when getting data
    func showOverlay() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    /// Remove Loader
    func hideOverlayView() {
        dismiss(animated: false, completion: nil)
        print("\(presentedViewController)")
    }
    
    /// Appply filter
    @objc func filterClicked() {
        presenter?.applyFilterIfApplicable()
    }
    
    /// Bar button item setup
    func addBarButton(filterOn: Bool) {
        var barButtonItem = UIBarButtonItem()
        if filterOn {
            barButtonItem = UIBarButtonItem(image: UIImage(systemName: "tray"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(filterClicked))
        } else {
            barButtonItem = UIBarButtonItem(image: UIImage(systemName: "tray")?.withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .done, target: self, action: #selector(filterClicked))
        }
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
}
