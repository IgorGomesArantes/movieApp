//
//  ApplicationCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {

    // MARK: - Properties
    private var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.barTintColor = UIColor(named: "yellow")
        
        navigationController.view.backgroundColor = UIColor(named: "yellow")
    
        return navigationController
    } ()
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return navigationController
    }
    let window: UIWindow
    
    // MARK: - Initialization methods
    init(window: UIWindow) {
        self.window = window
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Public methods
    func start() {
        let initializationData = HomeCoordinator.InitializationData(navigationController: navigationController)
        let homeCoordinator = HomeCoordinator(initializationData: initializationData)
        navigationController.viewControllers = [homeCoordinator.rootViewController]
        
        addChildCoordinator(homeCoordinator)
    }
}
