
import UIKit

class YellowViewController: UIViewController {

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toRootScene(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
