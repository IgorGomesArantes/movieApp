//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol HomeViewModelDelegate: class {
    func didSelectMovie(code: Int)
}

class HomeViewModel {

    // MARK: - Properties
    private var popular = [Movie]()
    private let movieService = MovieAPIManager()
    var coordinatorDelegate: HomeCoordinatorDelegate?
    weak var controllerDelegate: HomeViewControllerDelegate?
    
    // MARK: - Configuration properties
    var numberOfSections: Int {
        return 3
    }
    
    var numberOfRowsBySection: Int {
        return 1
    }
    
    // MARK: - Public methods
    func reload() {
        reloadPopular()
    }
    
    func detail(_ movieCode: Int) {
        coordinatorDelegate?.detail(movieCode)
    }
    
    func search() {
        coordinatorDelegate?.search()
    }
    
    // MARK: - Configure cell methods
    func configurePopularCell(_ cell: PopularTableViewCell) {
        cell.delegate = self
        cell.setup(movies: popular)
    }
    
    // MARK: - Reload methods
    private func reloadPopular() {
        controllerDelegate?.popular(.loading)
        
        movieService.getPopularMovies() {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.controllerDelegate?.popular(.empty)
                } else {
                    self.popular = result.results
                    self.controllerDelegate?.popular(.success(result))
                }
                
            case .error(let string):
                self.controllerDelegate?.popular(.error(string))
            }
        }
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    func didSelectMovie(code: Int) {
        detail(code)
    }
}
