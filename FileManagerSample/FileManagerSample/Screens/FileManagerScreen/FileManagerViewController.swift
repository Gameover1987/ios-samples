
import UIKit
import SnapKit

class FileManagerViewController: UIViewController {
    
    private let viewModel: FileManagerViewModel
    
    init(viewModel: FileManagerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let createDirectoryNotification = Notification.Name(rawValue: NotificationNames.createDirectory.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(createDirectoryNotificationHandler), name: createDirectoryNotification, object: nil)
        
        setupUI()
        bindViewModel()
    }
    
    @objc private func createDirectoryNotificationHandler(notification: Notification) {
        
        if let folderName = notification.userInfo?["folderName"] as? String {
            viewModel.createDirectory(directoryName: folderName)
            tableView.reloadData()
        }

    }
    
    private lazy var searchField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.placeholder = "File or folder name"
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Documents"
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add image", style: .done, target: self, action: #selector(addImageFromGallery))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create folder", style: .done, target: self, action: #selector(createFolder))
        
        view.addSubview(searchField)
        view.addSubview(tableView)
        
        searchField.snp.makeConstraints { maker in
            maker.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            maker.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.left.right.equalTo(view.safeAreaLayoutGuide).inset(0)
            maker.top.equalTo(searchField.snp.bottom).offset(8)
            maker.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    private func bindViewModel() {
        
    }
    
    @objc private func addImageFromGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func createFolder() {
        let addFolderController = AddFolderViewController()
        addFolderController.modalPresentationStyle = .fullScreen
        self.present(addFolderController, animated: true, completion: nil)
    }
}

extension FileManagerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            viewModel.saveImageToCurrentFolder(image: image)
            tableView.reloadData()
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension FileManagerViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntry = viewModel.entries[indexPath.row]
  
        if (selectedEntry.isFolder) {
            viewModel.changeDirectory(url: selectedEntry.url)
            tableView.reloadData()
        }
        else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension FileManagerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FileManagerTableViewCell(style: .default, reuseIdentifier: nil)
        cell.fileSystemEntry = viewModel.entries[indexPath.row]
        return cell
    }
}
