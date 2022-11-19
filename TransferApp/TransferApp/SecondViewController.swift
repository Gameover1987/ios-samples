
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var dataTextField: UITextField!
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach {viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
    var updatingData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(updatingData)
    }
    
    private func updateTextFieldData(_ data: String) {
        dataTextField.text = data
    }
}
