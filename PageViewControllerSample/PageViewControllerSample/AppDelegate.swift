//
//  AppDelegate.swift
//  PageViewControllerSample
//
//  Created by Вячеслав on 11.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let window = UIWindow()
        
        self.window = window
        
        let navigationController = UINavigationController()
        let pageViewController = MyPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        navigationController.setViewControllers([pageViewController], animated: true)
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
        
        return true
    }


}
