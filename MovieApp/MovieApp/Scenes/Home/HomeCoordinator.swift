//
//  HomeCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Abstract data
    struct HomeModule {
        let model: HomeViewModel
        let controller: HomeViewController
    }
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return homeModule.controller
    }
    lazy var homeModule: HomeModule = {
        return buildHomeModule()
    } ()
    
    let navigationController: UINavigationController
    
    // MARK: Initialization methods
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    func start() {
        
    }
    
    // MARK: - Build module methods
    private func buildHomeModule() -> HomeModule {
        let viewModel = HomeViewModel(movieService: MovieAPIManager(MockedRequest.success))
        let viewController = HomeViewController()
        
        return HomeModule(model: viewModel, controller: viewController)
    }
}
