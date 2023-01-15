
import UIKit

class WhiteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "White"
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageViewController  = self.parent as? UIPageViewController
        pageViewController?.title = title
    }
}

