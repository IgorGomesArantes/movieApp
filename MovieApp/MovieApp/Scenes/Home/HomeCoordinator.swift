//
//  HomeCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: class {
    func detail(_ movieCode: Int)
    func search()
}

class HomeCoordinator: Coordinator {
    
    // MARK: - Metadata
    struct InitializationData {
        let navigationController: UINavigationController
    }
    
    struct HomeModule {
        weak var model: HomeViewModel?
        let controller: HomeViewController
    }
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    lazy var homeModule: HomeModule = { return buildHomeModule() } ()
    var rootViewController: UIViewController { return homeModule.controller }
    
    // MARK: Initialization methods
    init(initializationData: InitializationData) {
        self.navigationController = initializationData.navigationController
    }
    
    func start() {
        
    }
    
    // MARK: - Build module methods
    private func buildHomeModule() -> HomeModule {
        let viewModel = HomeViewModel()
        
        let viewController = HomeViewController.instantiate(viewModel: viewModel)
        
        viewModel.controllerDelegate = viewController
        viewModel.coordinatorDelegate = self
        
        return HomeModule(model: viewModel, controller: viewController)
    }
}


// MARK: - Home coordinator delegate methods
extension HomeCoordinator: HomeCoordinatorDelegate {
    func detail(_ movieCode: Int) {
        let initializationData = DetailCoordinator.InitializationData(navigationController: navigationController, movieCode: movieCode)
        let detailCoordinator = DetailCoordinator(initializationData)
        
        addChildCoordinator(detailCoordinator)
    }
    
    func search() {
        let initializationData = SearchCoordinator.InitializationData(navigationController: navigationController)
        let searchCoordinator = SearchCoordinator(initializationData)
        
        addChildCoordinator(searchCoordinator)
    }
}
