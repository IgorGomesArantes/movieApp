//
//  HomeCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    struct HomeModule {
        let model: HomeViewModel
        let controller: HomeViewController
    }
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return homeModule.controller
    }
    lazy var homeModule: HomeModule = {
        return buildHomeModule()
    } ()
    
    func start() {
        
    }
    
    func buildHomeModule() -> HomeModule {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController()
        
        return HomeModule(model: viewModel, controller: viewController)
    }
}
