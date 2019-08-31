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
    func detail(movieCode: Int)
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
    weak var delegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return navigationController }
    let superNavigationController: UINavigationController
    let navigationController: UINavigationController
    var searchModule: SearchModule { return buildSearchModule() }
    
    // MARK: - Initialization methods
    init(_ initializationData: InitializationData) {
        self.superNavigationController = initializationData.navigationController
        self.navigationController = UINavigationController()
        self.navigationConfiguration()
    }
    
    func start() {
        superNavigationController.present(rootViewController, animated: true)
    }
    
    // MARK: - Build module methods
    private func buildSearchModule() -> SearchModule {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController.instanciate(viewModel: viewModel)
        
        viewModel.coordinatorDelegate = self
        
        return SearchModule(viewModel: viewModel, viewController: viewController)
    }
    
    // MARK: - Configuration methods
    private func navigationConfiguration() {
        navigationController.viewControllers = [searchModule.viewController]
        navigationController.isNavigationBarHidden = true
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.barTintColor = UIColor(named: "yellow")
        navigationController.view.backgroundColor = UIColor(named: "yellow")
    }
}

// MARK: - Search coordinator delegate methods
extension SearchCoordinator: SearchCoordinatorDelegate {
    func cancel() {
        superNavigationController.dismiss(animated: true) {
            self.delegate?.childDidFinish(self)
        }
    }
    
    func detail(movieCode: Int) {
        let detailCoordinator = DetailCoordinator(navigationController, movieService: MovieAPIManager(), movieCode: movieCode)
        
        addChildCoordinator(detailCoordinator)
        
        detailCoordinator.delegate = self
        navigationController.isNavigationBarHidden = false
    }
}

// MARK: - Search coordinator delegate methods
extension SearchCoordinator: CoordinatorDelegate {
    func childDidFinish(_ coordinator: Coordinator) {
        navigationController.isNavigationBarHidden = true
        removeChildCoordinator(coordinator)
    }
}
