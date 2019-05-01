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
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
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
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        navigationController.viewControllers = [homeCoordinator.rootViewController]
        
        addChildCoordinator(homeCoordinator)
    }
}
