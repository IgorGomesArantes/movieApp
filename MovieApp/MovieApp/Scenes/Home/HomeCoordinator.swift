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
        let requestProtocol: RequestProtocol
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
    let requestProtocol: RequestProtocol
    
    // MARK: Initialization methods
    init(initializationData: InitializationData) {
        self.navigationController = initializationData.navigationController
        self.requestProtocol = initializationData.requestProtocol
    }
    
    // MARK: - Public methods
    func start() {
        
    }
    
    // MARK: - Build module methods
    private func buildHomeModule() -> HomeModule {
        let viewModel = HomeViewModel(movieService: MovieAPIManager(requestProtocol))
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        
        return HomeModule(model: viewModel, controller: viewController)
    }
}
