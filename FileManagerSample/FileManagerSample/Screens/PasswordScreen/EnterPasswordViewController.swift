
import UIKit

class EnterPasswordViewController: UIViewController {

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

        view.backgroundColor = .white
        
        title = "Enter filemanager password"
        
        if (navigationController == nil) {
            view.addSubview(titleLabel)
        }
        
        view.addSubview(passwordTextField)
        view.addSubview(checkPassowordButton)
        
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
        
        checkPassowordButton.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        checkChangePasswordButtonState()
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "File manager access"
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
    
    private lazy var checkPassowordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.setTitle("Check passoword, and go on", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(checkPassowordButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func passwordsTextChanged(){
        checkChangePasswordButtonState()
    }
    
    @objc private func checkPassowordButtonAction() {
        let enteredPassword = passwordTextField.text
        let savedPassword = settings.password
        
        if (enteredPassword == savedPassword) {
            let fileManagerViewModel = FileManagerFactory.displayAtPath(FileSystemProvider.shared.getDocumentsDirectory())
            let fileManagerController = FileManagerViewController(fileManagerViewModel: fileManagerViewModel)
            let navigationController = UINavigationController(rootViewController: fileManagerController)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        } else {
            self.showAlert(title: "File manager access", message: "Wrong password")
        }
    }
    
    private func checkChangePasswordButtonState() {
        let isEnabled = passwordTextField.hasText
        checkPassowordButton.isEnabled = isEnabled
    }
}
