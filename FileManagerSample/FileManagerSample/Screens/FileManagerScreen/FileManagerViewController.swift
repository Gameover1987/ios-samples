
import UIKit
import SnapKit

final class FileManagerViewController: UIViewController {
    
    private let fileManagerViewModel: FileManagerViewModel
    
    init(fileManagerViewModel: FileManagerViewModel) {
        self.fileManagerViewModel = fileManagerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fileManagerViewModel.applySettings()
        
        tableView.reloadData()
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
    
    private lazy var addFolderButton: UIButton = {
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let image = UIImage(systemName: "folder", withConfiguration: config)
        let button = UIButton()
        
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(createFolder), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addImageButton: UIButton = {
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let image = UIImage(systemName: "photo", withConfiguration: config)
        let button = UIButton()
        
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(addImageFromGallery), for: .touchUpInside)
        
        return button
    }()
    
    private func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .always
                
        self.title = fileManagerViewModel.currentDirectory?.lastPathComponent
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonAction))
        
        view.addSubview(searchField)
        view.addSubview(tableView)
        view.addSubview(addFolderButton)
        view.addSubview(addImageButton)
        
        searchField.snp.makeConstraints { maker in
            maker.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            maker.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.left.right.equalTo(view.safeAreaLayoutGuide).inset(0)
            maker.top.equalTo(searchField.snp.bottom).offset(8)
            maker.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        addFolderButton.snp.makeConstraints { maker in
            maker.left.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            maker.width.equalTo(50)
            maker.height.equalTo(50)
        }
        
        addImageButton.snp.makeConstraints { maker in
            maker.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            maker.width.equalTo(50)
            maker.height.equalTo(50)
        }
    }
    
    @objc private func settingsButtonAction() {
        let settingsViewController = SettingsViewController(settings: Settings.shared)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc private func addImageFromGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func createFolder() {
        let addFolderController = AddFolderViewController(fileManagerViewModel: fileManagerViewModel)
        addFolderController.createDirectoryAction = { [weak self] directoryName in
            self?.fileManagerViewModel.createDirectory(directoryName: directoryName)
            self?.tableView.reloadData()
        }
        self.present(addFolderController, animated: true, completion: nil)
    }
    
    private func moveToTrash(indexPath: IndexPath) {
        fileManagerViewModel.deleteEntry(position: indexPath.row)
        tableView.reloadData()
    }
}

extension FileManagerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            fileManagerViewModel.saveImageToCurrentFolder(image: image)
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
        let selectedEntry = fileManagerViewModel.entries[indexPath.row]
        
        if (selectedEntry.isFolder) {
            navigationController?.pushViewController(FileManagerViewController(fileManagerViewModel: FileManagerFactory.displayAtPath(selectedEntry.url)), animated: true)
        }
        else {
            let openImageViewController = OpenImageViewController(fileSystemProvider: FileSystemProvider.shared)
            openImageViewController.openImage(url: selectedEntry.url)
            self.present(openImageViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let deleteAction = UIContextualAction(style: .destructive,
                                       title: "Del") { [weak self] (action, view, completionHandler) in
            self?.moveToTrash(indexPath: indexPath)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension FileManagerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileManagerViewModel.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FileManagerTableViewCell(style: .default, reuseIdentifier: nil)
        cell.fileSystemEntry = fileManagerViewModel.entries[indexPath.row]
        return cell
    }
}
