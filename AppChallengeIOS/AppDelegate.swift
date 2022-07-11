//
//  AppDelegate.swift
//  AppChallenge
//
//  Created by Timo Kilb  on 06.07.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        
        let rootViewController = UINavigationController()
        
        window?.rootViewController = rootViewController
        
        let viewCon = ViewController()
        let viewModel = ViewModel()
        viewCon.viewModel = viewModel
        

        
        return true
    }

}

