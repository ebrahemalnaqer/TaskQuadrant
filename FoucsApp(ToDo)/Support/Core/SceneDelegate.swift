//
//  SceneDelegate.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window                      = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        let rootViewController = HomeVC()
        window?.rootViewController = UINavigationController(rootViewController:rootViewController)
        window?.makeKeyAndVisible()
        
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
}

