
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window

        let fileManagerViewModel = FileManagerViewModel(fileSystemProvider: FileSystemProvider.shared)
        fileManagerViewModel.changeDirectory(url: FileSystemProvider.shared.getDocumentsDirectory())
        let fileManagerController = FileManagerViewController(viewModel: fileManagerViewModel)
        
        let navigationController = UINavigationController(rootViewController: fileManagerController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return true
    }
}
