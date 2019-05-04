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
        return navigationController
    } ()
    
    private var requestProtocol: RequestProtocol = {
        switch Configuration.shared.environment {
        case .staging:
            return MockedRequest.success
        default:
            return HTTPRequest()
        }
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
        let initializationData = HomeCoordinator.InitializationData(navigationController: navigationController, requestProtocol: requestProtocol)
        let homeCoordinator = HomeCoordinator(initializationData: initializationData)
        navigationController.viewControllers = [homeCoordinator.rootViewController]
        
        addChildCoordinator(homeCoordinator)
    }
}