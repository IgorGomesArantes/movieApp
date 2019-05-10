//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Abstract data
    enum options {
        case myList(_ response: (ServiceStatus<[Movie]>))
        case recomendations(_ response: (ServiceStatus<[Movie]>))
        case popular(_ response: (ServiceStatus<MoviePage>))
    }
    
    // MARK: - Constants
    private let pageSize = 10
    private let currentPopularPage = 1
    
    // MARK: - Properties
    private let movieService: MovieAPIManager
    private var myList: [Movie]?
    private var recomendations: [Movie]?
    private var popular: MoviePage = MoviePage()
    weak var delegate: HomeViewControllerDelegate?
    
    var onResponse: ((options) -> Void)?
    
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
        onResponse?(.popular(.loading))
        
        movieService.getPopularMovies(page: currentPopularPage, pageSize: pageSize) {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.onResponse?(.popular(.empty))
                } else {
                    self.onResponse?(.popular(.success(result)))
                }
                
            case .error(let string):
                self.onResponse?(.popular(.error(string)))
            }
        }
    }
    
    private func reloadMyList() {
        
    }
    
    private func reloadRecomendations() {
        
    }
}
