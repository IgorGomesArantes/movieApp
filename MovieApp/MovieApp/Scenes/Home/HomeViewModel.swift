//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeViewModel {

    // MARK: - Constants
    private let pageSize = 10
    private let currentPopularPage = 1
    
    // MARK: - Properties
    private let movieService: MovieAPIManager
    private var popular: MoviePage = MoviePage()
    // TODO: - estudar weak
    var coordinatorDelegate: HomeCoordinatorDelegate?
    weak var controllerDelegate: HomeViewControllerDelegate?
    
    // MARK - Initialization methods
    init() {
        self.movieService = MovieAPIManager()
    }
    
    // MARK: - Public methods
    func reload() {
        reloadPopular()
    }
    
    func popularDetail(_ index: Int) {
        coordinatorDelegate?.detail(index)
    }
    
    func search() {
        coordinatorDelegate?.search()
    }
    
    func configure(_ view: HomeView) {
        
    }
    
    // MARK: - Reload auxiliar methods
    private func reloadPopular() {
        controllerDelegate?.popular(.loading)
        
        movieService.getPopularMovies(page: currentPopularPage, pageSize: pageSize) {
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
    
    // MARK: - Popular methods and properties
    var popularCount: Int {
        return popular.results.count
    }
    
    func popularViewModel(index: Int) -> PopularViewModel {
        let movieCode = popular.results[index].id ?? 0
        let imagePath = movieService.getImagePath(popular.results[index].posterPath ?? "")
        let voteAverage = popular.results[index].voteAverage ?? 0.0
        
        let viewModel = PopularViewModel(movieCode: movieCode, imagePath: imagePath, voteAverage: voteAverage)
        
        return viewModel
    }
}
