
import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Red"
        
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageViewController  = self.parent as? UIPageViewController
        pageViewController?.title = title
    }
}
