
import UIKit
import SnapKit

class MyPageViewController: UIPageViewController {
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
        return pageControl
    }()
    
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue

        self.delegate = self
        self.dataSource = self
        
        setViewControllers([coloredControllers.first!], direction: .forward, animated: true)
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        settingsItem.tintColor = .black
        
        let locationItem = UIBarButtonItem(image: UIImage(systemName: "mappin.circle"), style: .plain, target: self, action: #selector(addController))
        locationItem.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = locationItem
        self.navigationItem.leftBarButtonItem = settingsItem
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.numberOfPages = coloredControllers.count
        pageControl.currentPage = 0
    }
    
    @objc
    private func addController() {
        let greenController = GreenViewController()
        coloredControllers.insert(greenController, at: 0)
        
        pageControl.numberOfPages = coloredControllers.count
        
        setViewControllers([greenController], direction: .forward, animated: true)
    }
    
    private lazy var coloredControllers: [UIViewController] = {
        return [WhiteViewController(), BlueViewController(), RedViewController()]
    }()
}

extension MyPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          
        guard let firstViewController = viewControllers?.first else { return }
           
        guard let index = coloredControllers.firstIndex(of: firstViewController) else { return }
       
        pageControl.currentPage = index

    }
}

extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = coloredControllers.firstIndex(of: viewController) {
           
            if index > 0 {
                currentIndex = index - 1
                return coloredControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = coloredControllers.firstIndex(of: viewController) {
          
            if index < coloredControllers.count - 1 {
                currentIndex = index + 1
                return coloredControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageControl.numberOfPages
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageControl.currentPage
    }
}
