
import UIKit

final class GreenViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Green"
        
        view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageViewController  = self.parent as? UIPageViewController
        pageViewController?.title = title
    }
}
