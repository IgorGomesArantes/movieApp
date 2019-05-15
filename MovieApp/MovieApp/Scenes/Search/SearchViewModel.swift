//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class SearchViewModel {
    
    // MARK: - Properties
    private let movieService = MovieAPIManager()
    private var movies = [Movie]()
    private var query = ""
    var coordinatorDelegate: SearchCoordinatorDelegate?
    weak var controllerDelegate: SearchViewControllerDelegate?
    
    var resultCount: Int {
        return movies.count
    }
    
    // MARK: - Public methods
    func reload(query: String) {
        controllerDelegate?.reload(.loading)
        
        movieService.getMovies(by: query) {
            switch($0) {
            case .success(let result):
                self.movies = result.results
                
                if self.movies.isEmpty {
                    self.controllerDelegate?.reload(.empty)
                } else {
                    self.controllerDelegate?.reload(.success(self.movies))
                }
            case .error(let string):
                self.controllerDelegate?.reload(.error(string))
            }
        }
    }
    
    func configureCell(_ cell: ResultCollectionViewCell, index: Int) {
        let code = movies[index].id ?? 0
        let path = movies[index].posterPath ?? ""
        let imagePath = movieService.getImagePath(path)
        
        let resultViewModel = ResultViewModel(movieCode: code, imagePath: imagePath)
        
        cell.setup(resultViewModel)
    }
    
    func cancel() {
        coordinatorDelegate?.cancel()
    }
}
