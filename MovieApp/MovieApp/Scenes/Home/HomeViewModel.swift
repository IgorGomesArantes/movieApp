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
        case popular(_ response: (ServiceStatus<[Movie]>))
    }
    
    // MARK: - Properties
    private let movieService: MovieAPIManager
    private var myList: [Movie]?
    private var recomendations: [Movie]?
    private var popular: [Movie]?
    
    var onResponse: ((options) -> Void)?
    
    // MARK - Initialization methods
    init(movieService: MovieAPIManager) {
        self.movieService = movieService
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
        
        movieService.getPopularMovies(page: 1, pageSize: 10) {
            switch $0 {
            case .success(let result):
                if result.isEmpty {
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
