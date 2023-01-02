
import UIKit
import KeychainAccess

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window
        
        let savedPassword = Settings.shared.password
        if (savedPassword == nil) {
            window.rootViewController = CreatePasswordViewController(settings: Settings.shared)
        } else {
            window.rootViewController = EnterPasswordViewController(settings: Settings.shared)
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
}
