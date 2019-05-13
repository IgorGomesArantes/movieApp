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
    private var myList: [Movie]?
    private var recomendations: [Movie]?
    private var popular: MoviePage = MoviePage()
    weak var controllerDelegate: HomeViewControllerDelegate?
    weak var coordinatorDelegate: HomeCoordinatorDelegate?
    
    // MARK - Initialization methods
    init() {
        self.movieService = MovieAPIManager()
    }
    
    // MARK: - Public methods
    func reload() {
        reloadPopular()

        reloadMyList()
        reloadRecomendations()
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
    
    private func reloadMyList() {
        
    }
    
    private func reloadRecomendations() {
        
    }
    
    // MARK: - Public methods
    func configure(_ view: HomeView) {
        
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
    
    func popularDetail(_ index: Int) {
        
    }
}
