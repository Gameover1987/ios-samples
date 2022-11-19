
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private var users = [User]()
    
    private lazy var fetchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.setTitle("Load data", for: .normal)
        button.addTarget(self, action: #selector(fetchAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(dataContext: MainViewModel) {
        self.viewModel = dataContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        bindViewModel()
    }
    
    private func setupLayout() {
        view.addSubview(fetchButton)
        fetchButton.snp.makeConstraints { (button) -> Void in
            button.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            button.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            button.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            button.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ (tableView) -> Void in
            tableView.top.equalTo(fetchButton.snp.bottom).offset(16)
            tableView.left.equalToSuperview()
            tableView.right.equalToSuperview()
            tableView.bottom.equalToSuperview()
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints{ (indicator) -> Void in
            indicator.centerX.equalToSuperview()
            indicator.centerY.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.stateChanged = { [weak self] state in
            switch state {
            case .initial:
                ()
                print("Initial")
                
            case .loading:
                self?.activityIndicator.startAnimating()
                
            case .loaded(let users):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.users = users
                    self?.tableView.reloadData()
                }
               
            case .error:
                print("Error")
            }
        }
    }
    
    @objc func fetchAction() {
        users.removeAll()
        tableView.reloadData()
        
        viewModel.loadUsers()
    }
}


extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectUser(user: users[indexPath.row])
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        content.text = users[indexPath.row].name
        content.secondaryText = "Age \(users[indexPath.row].age) years"
        cell.contentConfiguration = content
        return cell
    }
    
}
