//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 14/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .yellow
        
        let teste = Configuration.shared.environment
        debugPrint(teste)
 
        window = UIWindow()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

