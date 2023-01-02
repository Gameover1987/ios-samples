
import UIKit

class SettingsViewController: UIViewController {

    private var settings: SettingsProtocol
    
    init(settings: SettingsProtocol) {
       
        self.settings = settings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        title = "Settings"
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}

extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let sortingViewController = SortingViewController(settings: settings)
            navigationController?.pushViewController(sortingViewController, animated: true)
        }
        
        if (indexPath.row == 1) {
            let createPasswordViewController = CreatePasswordViewController(settings: settings)
            navigationController?.pushViewController(createPasswordViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if (indexPath.row == 0) {
           
            cell.imageView?.image = UIImage(systemName: "arrow.up.arrow.down")
            cell.textLabel?.text = "Sorting"
            cell.detailTextLabel?.text = settings.sortingMode.rawValue
            
            return cell
        }
        
        if (indexPath.row == 1) {
            cell.imageView?.image = UIImage(systemName: "key")
            cell.textLabel?.text = "Change password"
            
            return cell
        }
        
        fatalError()
    }
    
    
}
