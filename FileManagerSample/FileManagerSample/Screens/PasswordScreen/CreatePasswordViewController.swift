
import UIKit
import SnapKit

class CreatePasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Changing pasword"
        
        view.backgroundColor = .white
        
        view.addSubview(passwordTextField)
        view.addSubview(passwordAgainTextField)
        view.addSubview(changePasswordButton)
        
        passwordTextField.snp.makeConstraints { make in
            make.left.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
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
    
    @objc private func passwordsTextChanged(){
        checkChangePasswordButtonState()
    }
    
    @objc private func changePasswordAction() {
        
    }
    
    private func checkChangePasswordButtonState() {
        let isEnabled = passwordTextField.hasText &&
                        passwordAgainTextField.hasText &&
                        passwordTextField.text == passwordAgainTextField.text
        
        changePasswordButton.isEnabled = isEnabled
    }
    
}
