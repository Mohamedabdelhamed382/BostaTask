//
//  SceneDelegate.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 28/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let profileViewModel = ProfileViewModel()
        let rootcontroller = ProfileViewController(viewModel: profileViewModel)
        let window = UIWindow(windowScene: windowScene)
        let navgationController = UINavigationController(rootViewController: rootcontroller)
        window.rootViewController = navgationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

