//
//  SortingViewController.swift
//  FileManagerSample
//
//  Created by Вячеслав on 02.01.2023.
//

import UIKit

class SortingViewController: UIViewController {
    
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
        
        title = "Sorting"
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension SortingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortingMode: SortingMode = SortingMode.allCases[indexPath.row]
        self.settings.sortingMode = sortingMode
        
        print(self.settings.sortingMode)
        
        tableView.reloadData()
    }
    
}

extension SortingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortingMode.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let sortingModeByCell = SortingMode.allCases[indexPath.row]
        cell.textLabel?.text = sortingModeByCell.rawValue
        if (settings.sortingMode == sortingModeByCell) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
}
