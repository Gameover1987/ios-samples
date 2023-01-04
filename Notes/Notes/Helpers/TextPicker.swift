
import UIKit

final class TextPicker {
    static let shared = TextPicker()
    
    private init() {
        
    }
    
    func showIn(viewController: UIViewController, title: String, placeHolder: String, completion: ((_ text: String) -> Void)?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeHolder
        }
        
        let actionAdd = UIAlertAction(title: "OK", style: .default) { action in
            if let text = alertController.textFields?.first?.text, text != "" {
                completion?(text)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(actionAdd)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
    
    func showIn(viewController: UIViewController, title: String, message: String, completion: ((_ text: String) -> Void)?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = message
        }
        
        let actionAdd = UIAlertAction(title: "OK", style: .default) { action in
            if let text = alertController.textFields?.first?.text, text != "" {
                completion?(text)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(actionAdd)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
}
