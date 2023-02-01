//
//  AppDelegate.swift
//  JsonParseSample1
//
//  Created by Вячеслав on 17.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        JsonParser.parse()
        
        return true
    }
}

