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
        
//        var movie: Movie?
//        let manager = MovieAPIManager(MockedRequest.success)
//        manager.getMovie(code: 1) { response in
//            switch(response) {
//            case .success(let result):
//                    movie = result
//            case .error:
//                    break
//            }
//        }
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = ApplicationCoordinator(window: window!)
        appCoordinator.start()
        
        return true
    }
}

