
import UIKit
import SnapKit
import LocalAuthentication

class ViewController: UIViewController {

    private let biometricAuthId = BiometricIDAuth()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setImage(UIImage(systemName: "touchid"), for: .normal)
        button.addTarget(self, action: #selector(performBiometricAuth), for: .touchUpInside)
        button.imageEdgeInsets.left = -10
        //button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        print("Biometric type available: \(biometricAuthId.biometryType)")
        
        view.addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func performBiometricAuth() {
        biometricAuthId.canEvaluate { success, biometricType, error in
            guard success else {
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Biometry should be configured!")
                return
            }
            print("Biometric type available: \(biometricAuthId.biometryType)")
            
            
            biometricAuthId.evaluate { success, error in
                guard success else {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Biometry should be configured!")
                    return
                }
                
                print("Biometric type available: \(self.biometricAuthId.biometryType)")
                
                self.showAlert(title: "Success", message: "Biometric authentication passed successfully!")
            }
        }
    }
    
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
