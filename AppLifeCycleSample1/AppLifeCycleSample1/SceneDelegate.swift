//
//  SceneDelegate.swift
//  AppLifeCycleSample1
//
//  Created by Вячеслав on 11.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = ViewController()
        let navigtaionController = UINavigationController(rootViewController: viewController)
        navigtaionController.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigtaionController
        window.makeKeyAndVisible()
        
        self.window = window
    }


}

