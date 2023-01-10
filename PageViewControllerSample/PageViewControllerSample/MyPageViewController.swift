
import UIKit

class MyPageViewController: UIPageViewController {
    
    var pageControl = UIPageControl()
//
//    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
//        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
//        self.view.backgroundColor = .red
//        setViewControllers([self.coloredControllers[0]], direction: .forward, animated: true)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        setViewControllers([coloredControllers.first!], direction: .forward, animated: true)
        
        // 2: set y = 0 means top or UIScreen.main.bounds.maxY - offset
        pageControl = UIPageControl(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width, height: 135))
        
        self.pageControl.numberOfPages = coloredControllers.count
        self.pageControl.tintColor = UIColor.lightGray
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
        
        self.view.addSubview(pageControl)
    }
    
    private lazy var coloredControllers: [UIViewController] = {
        return [WhiteViewController(), BlueViewController(), RedViewController()]
    }()
}

extension MyPageViewController: UIPageViewControllerDelegate {
  
}

extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = coloredControllers.firstIndex(of: viewController) {
            pageControl.currentPage = index
            if index > 0 {
                return coloredControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = coloredControllers.firstIndex(of: viewController) {
            pageControl.currentPage = index
            if index < coloredControllers.count - 1 {
                return coloredControllers[index + 1]
            }
        }
        return nil
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return pageControl.numberOfPages
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return pageControl.currentPage
//    }
}
