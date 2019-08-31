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
    private var searchTimer: Timer? = nil
    private let movieService = MovieAPIManager()
    private var movies = [Movie]()
    var coordinatorDelegate: SearchCoordinatorDelegate?
    var onChange: ((ServiceStatus) -> ())?
    
    var resultCount: Int {
        return movies.count
    }
    
    var searchQuery: String = "" 
    
    // MARK: - Public methods
    @objc func reload() {
        let formattedQuery = searchQuery.replacingOccurrences(of: " ", with: "+")
        
        onChange?(.loading)
        
        movieService.getMovies(by: formattedQuery) {
            switch($0) {
            case .success(let result):
                self.movies = result.results
                
                if self.movies.isEmpty {
                    self.onChange?(.empty)
                } else {
                    self.onChange?(.success)
                }
            case .error(let string):
                self.onChange?(.error(string))
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
    
    func selectItem(at index: Int) {
        let movieCode = movies[index].id ?? 0
        
        coordinatorDelegate?.detail(movieCode: movieCode)
    }
    
    // MARK: - Timer methods
    func startSearchTimer() {
        searchTimer =  Timer.scheduledTimer(
            timeInterval: TimeInterval(0.8),
            target      : self,
            selector    : #selector(reload),
            userInfo    : nil,
            repeats     : false)
    }
    
    func stopSearchTimer() {
        searchTimer?.invalidate()
        searchTimer = nil
    }
}
