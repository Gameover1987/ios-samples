
import UIKit
import SnapKit

class CreatePasswordViewController: UIViewController {

    private var settings: SettingsProtocol
    
    init(settings: SettingsProtocol) {
       
        self.settings = settings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Changing pasword"
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordAgainTextField)
        view.addSubview(changePasswordButton)
      
        if (navigationController == nil) {
            titleLabel.snp.makeConstraints { make in
                make.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
                make.height.equalTo(50)
            }
            passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).inset(8)
                make.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
                make.height.equalTo(50)
            }
        } else {
            passwordTextField.snp.makeConstraints { make in
                make.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
                make.height.equalTo(50)
            }
        }
        
        passwordAgainTextField.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(passwordTextField.snp.bottom).inset(8)
            make.height.equalTo(50)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(passwordAgainTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        checkChangePasswordButtonState()
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create file manager password"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextFileld = UITextField()
        passwordTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        passwordTextFileld.textColor = .black
        passwordTextFileld.placeholder = "Password"
        passwordTextFileld.font = .systemFont(ofSize: 16.0)
        passwordTextFileld.isSecureTextEntry = true
        passwordTextFileld.addTarget(self, action: #selector(passwordsTextChanged), for: .editingChanged)
        return passwordTextFileld
    }()
    
    private lazy var passwordAgainTextField: UITextField = {
        let passwordTextFileld = UITextField()
        passwordTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        passwordTextFileld.textColor = .black
        passwordTextFileld.placeholder = "Password again"
        passwordTextFileld.font = .systemFont(ofSize: 16.0)
        passwordTextFileld.isSecureTextEntry = true
        passwordTextFileld.addTarget(self, action: #selector(passwordsTextChanged), for: .editingChanged)
        return passwordTextFileld
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.setTitle("Let's do it", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(changePasswordAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func passwordsTextChanged() {
        checkChangePasswordButtonState()
    }
    
    @objc private func changePasswordAction() {
        
        settings.password = passwordTextField.text
        
        if navigationController == nil {
            let fileManagerViewModel = FileManagerFactory.displayAtPath(FileSystemProvider.shared.getDocumentsDirectory())
            let fileManagerController = FileManagerViewController(fileManagerViewModel: fileManagerViewModel)
            let navigationController = UINavigationController(rootViewController: fileManagerController)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func checkChangePasswordButtonState() {
        let isEnabled = passwordTextField.hasText &&
                        passwordTextField.text!.count >= 4 &&
                        passwordAgainTextField.hasText &&
                        passwordAgainTextField.text!.count >= 4 &&
                        passwordTextField.text == passwordAgainTextField.text
        
        changePasswordButton.isEnabled = isEnabled
    }
    
}
