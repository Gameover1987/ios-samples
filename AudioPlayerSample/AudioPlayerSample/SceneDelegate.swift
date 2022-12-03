//
//  SceneDelegate.swift
//  AudioPlayerSample
//
//  Created by Вячеслав on 03.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Перечисление дочерних контроллеров.
        let audioPlayerController = AudioPlayerViewController(playlistProvider: PlaylistProvider.shared)
        let videoPlayerController = VideoPlayerController()
        
        // Создание заголовков для контроллеров.
        audioPlayerController.title = "Audio player"
        videoPlayerController.title = "Video player"
        
        // Создания item'ов в tabBar.
        let itemFeedView = UITabBarItem()
        let itemProfileView = UITabBarItem()
        
        // Соединяем item'ы с нужными viewController'ми.
        audioPlayerController.tabBarItem = itemFeedView
        videoPlayerController.tabBarItem = itemProfileView
        
        // Добавление изображения к item'м tabBarController'a.
        itemFeedView.image = UIImage(systemName: "music.note.list")
        itemProfileView.image = UIImage(systemName: "video")
        
        // Делаем из наших контроллеров, новый стек.
        let audioNavigationController = UINavigationController(rootViewController: audioPlayerController)
        audioNavigationController.navigationBar.prefersLargeTitles = true
        let videoNavigationController = UINavigationController(rootViewController: videoPlayerController)
        videoNavigationController.navigationBar.prefersLargeTitles = true
        
        // Создание tabBar и добавление в него, навигационных стеков, и по умолчаниию, выбираем экран с постами.
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [audioNavigationController, videoNavigationController]
        tabBarController.selectedViewController = audioNavigationController
        
        // Делаем tabBar ключевым в нашем окне.
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
