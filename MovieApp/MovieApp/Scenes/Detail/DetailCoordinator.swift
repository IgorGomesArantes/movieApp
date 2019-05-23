//
//  DetailCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol DetailCoordinatorDelegate {
    func detail(_ movieCode: Int)
    func back()
}

class DetailCoordinator: Coordinator {
    
    // MARK: - Metadata
    struct InitializationData {
        let navigationController: UINavigationController
        let movieCode: Int
    }
    
    struct DetailModule {
        weak var viewModel: DetailViewModel?
        let controller: DetailViewController
    }
    
    // MARK: - Properties
    weak var delegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return detailModule.controller }
    
    let movieCode: Int
    let navigationController: UINavigationController
    var detailModule: DetailModule { return buildDetailModule() }
    
    // MARK: - Initialization methods
    init(_ initializationData: InitializationData) {
        self.movieCode = initializationData.movieCode
        self.navigationController = initializationData.navigationController
    }
    
    func start() {
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    // MARK: - Build module methods
    private func buildDetailModule() -> DetailModule {
        let viewModel = DetailViewModel(movieCode)
        let viewController = DetailViewController.instanciate(viewModel: viewModel)
        
        viewModel.controllerDelegate = viewController
        viewModel.coordinatorDelegate = self
        
        return DetailModule(viewModel: viewModel, controller: viewController)
    }
}

// MARK: - Coordinator delegate methdos
extension DetailCoordinator: CoordinatorDelegate {
    func childDidFinish(_ coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}

// MARK: - Detail coordinator delegate methods
extension DetailCoordinator: DetailCoordinatorDelegate {
    func detail(_ movieCode: Int) {
        let initializationData = DetailCoordinator.InitializationData(navigationController: navigationController, movieCode: movieCode)
        let detailCoordinator = DetailCoordinator(initializationData)
        
        addChildCoordinator(detailCoordinator)
        
        detailCoordinator.delegate = self
    }
    
    func back() {
        delegate?.childDidFinish(self)
    }
}
