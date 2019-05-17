//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol HomeViewModelDelegate: class {
    func didSelectAt(index: Int)
}

class HomeViewModel {

    // MARK: - Constants
    private let currentPopularPage = 1
    
    // MARK: - Properties
    private let movieService = MovieAPIManager()
    var popular: MoviePage = MoviePage()
    var coordinatorDelegate: HomeCoordinatorDelegate?
    weak var controllerDelegate: HomeViewControllerDelegate?
    
    // MARK: - Public methods
    func reload() {
        reloadPopular()
    }
    
    func popularDetail(_ movieCode: Int) {
        coordinatorDelegate?.detail(movieCode)
    }
    
    func search() {
        coordinatorDelegate?.search()
    }
    
    func configurePopularCell(_ cell: PopularTableViewCell) {
        cell.delegate = self
        cell.setup(movies: popular.results)
    }
    
    // MARK: - Reload methods
    private func reloadPopular() {
        controllerDelegate?.popular(.loading)
        
        movieService.getPopularMovies(page: currentPopularPage) {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.controllerDelegate?.popular(.empty)
                } else {
                    self.popular = result
                    self.controllerDelegate?.popular(.success(result))
                }
                
            case .error(let string):
                self.controllerDelegate?.popular(.error(string))
            }
        }
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    func didSelectAt(index: Int) {
        let movieCode = popular.results[index].id ?? 0
        
        popularDetail(movieCode)
    }
}
