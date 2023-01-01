
import Foundation
import UIKit

final class AddFolderViewController : UIViewController {
    
    private let fileManagerViewModel: FileManagerViewModel
    
    init(fileManagerViewModel: FileManagerViewModel) {
        self.fileManagerViewModel = fileManagerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Folder name"
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.setTitle("Let's do it", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        
        view.addSubview(textField)
        view.addSubview(okButton)
        
        view.backgroundColor = .white
        
        textField.snp.makeConstraints { maker in
            maker.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            maker.height.equalTo(40)
        }
        
        okButton.snp.makeConstraints { maker in
            maker.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            maker.top.equalTo(textField.snp.bottom).offset(8)
            maker.height.equalTo(50)
        }
        
        textChanged()
    }
    
    public var createDirectoryAction: ((_ directoryName: String) -> Void)?
    
    @objc private func textChanged() {
        okButton.isEnabled = textField.hasText
    }
    
    @objc private func okAction() {
        
        createDirectoryAction?(textField.text!)
        
        self.dismiss(animated: true, completion: nil)
    }
}
