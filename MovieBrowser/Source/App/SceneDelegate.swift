//
//  SceneDelegate.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.topViewController?.title = "Movie Search"
        self.window?.rootViewController = searchNav
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.systemBlue
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            searchNav.navigationBar.standardAppearance = appearance;
            searchNav.navigationBar.scrollEdgeAppearance = searchNav.navigationBar.standardAppearance
        }
        
        setNavBar()
    }
    
    func setNavBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 13.0, *) {
            UINavigationBar.appearance().backgroundColor = .systemBlue
        }
        
        
    }
}
