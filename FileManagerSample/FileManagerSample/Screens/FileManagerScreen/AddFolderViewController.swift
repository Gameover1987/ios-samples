
import Foundation
import UIKit

final class AddFolderViewController : UIViewController {
    
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
    
    func getFolderName() -> String {
        return textField.text!
    }
    
    @objc func textChanged() {
        okButton.isEnabled = textField.hasText
    }
    
    @objc func okAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
