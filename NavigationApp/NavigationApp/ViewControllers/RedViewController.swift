
import UIKit

class RedViewController: UIViewController {

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toGreenScene(_ sender: UIButton) {
        let greenViewController = mainStoryboard.instantiateViewController(withIdentifier: "greenViewController")
        navigationController?.pushViewController(greenViewController, animated: true)
    }
}


