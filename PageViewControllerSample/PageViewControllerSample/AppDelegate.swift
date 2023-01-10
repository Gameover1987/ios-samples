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
        
        let pageViewController = MyPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        window.rootViewController = pageViewController
        
        window.makeKeyAndVisible()
        
        return true
    }


}
