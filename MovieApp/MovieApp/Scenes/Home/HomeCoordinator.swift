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
    struct InitializationData {
        let navigationController: UINavigationController
    }
    
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
    init(initializationData: InitializationData) {
        self.navigationController = initializationData.navigationController
    }
    
    // MARK: - Public methods
    func start() {
        
    }
    
    // MARK: - Build module methods
    private func buildHomeModule() -> HomeModule {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        
        return HomeModule(model: viewModel, controller: viewController)
    }
}
