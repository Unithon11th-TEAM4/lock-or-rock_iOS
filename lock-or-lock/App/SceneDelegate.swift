//
//  SceneDelegate.swift
//  lock-or-lock
//
//  Created by 박현준 on 4/6/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
                    let navigationController = UINavigationController(rootViewController: ProposeQuestionViewController())
                    window?.rootViewController = navigationController
        // 분기 처리
//        if TokenManager.shared.getUserId() != nil {
//            let navigationController = UINavigationController(rootViewController: HomeViewController())
//            window?.rootViewController = navigationController
//        } else {
//            let navigationController = UINavigationController(rootViewController: SetNicknameViewController())
//            window?.rootViewController = navigationController
//        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

