
import UIKit

class GreenViewController: UIViewController {

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func toYellowScene(_ sender: UIButton) {
        let greenViewController = mainStoryboard.instantiateViewController(withIdentifier: "yellowViewController")
        navigationController?.pushViewController(greenViewController, animated: true)
    }
}
