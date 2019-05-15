//
//  SearchCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol SearchCoordinatorDelegate: class {
    func cancel()
}

class SearchCoordinator: Coordinator {
    
    // MARK: - Metadata
    struct InitializationData {
        let navigationController: UINavigationController
    }
    
    struct SearchModule {
        weak var viewModel: SearchViewModel?
        let viewController: SearchViewController
    }
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return searchModule.viewController }
    let navigationController: UINavigationController
    var searchModule: SearchModule { return buildSearchModule() }
    
    // MARK: - Initialization methods
    init(_ initializationData: InitializationData) {
        self.navigationController = initializationData.navigationController
    }
    
    func start() {
        navigationController.present(rootViewController, animated: true, completion: nil)
    }
    
    // MARK: - Build module methods
    private func buildSearchModule() -> SearchModule {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController.instanciate(viewModel: viewModel)
        
        viewModel.controllerDelegate = viewController
        viewModel.coordinatorDelegate = self
        
        return SearchModule(viewModel: viewModel, viewController: viewController)
    }
}

// TODO: - Corrigir com navigation manager
// MARK: - Search coordinator delegate methods
extension SearchCoordinator: SearchCoordinatorDelegate {
    func cancel() {
        navigationController.dismiss(animated: false, completion: nil)
    }
}
