//
//  DetailCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    // MARK: - Metadata
    struct DetailModule {
        var viewModel: DetailViewModel
        let controller: DetailViewController
    }
    
    // MARK: - Properties
    weak var delegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return detailModule.controller }
    
    private let movieCode: Int
    private let movieService: MovieAPIManager
    private let navigationController: UINavigationController
    private lazy var detailModule = buildDetailModule()
    
    // MARK: - Initialization methods
    init(_ navigationController: UINavigationController, movieService: MovieAPIManager, movieCode: Int) {
        self.navigationController = navigationController
        self.movieService = movieService
        self.movieCode = movieCode
    }
    
    deinit {
        debugPrint("Detail coordinator deinit")
    }
    
    // MARK: - Start methods
    func start() {
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    // MARK: - Build module methods
    private func buildDetailModule() -> DetailModule {
        let viewModel = DetailViewModel(movieService, movieCode: movieCode)
        let viewController = DetailViewController.instanciate(viewModel: viewModel)
        
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

// MARK: - Detail view model delegate methods
extension DetailCoordinator: DetailViewModelDelegate {
    func detail(_ movieCode: Int) {
        let detailCoordinator = DetailCoordinator(navigationController, movieService: movieService, movieCode: movieCode)
        
        addChildCoordinator(detailCoordinator)
        
        detailCoordinator.delegate = self
    }
    
    func back() {
        delegate?.childDidFinish(self)
    }
}
