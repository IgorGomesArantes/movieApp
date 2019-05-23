//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

enum HomeSectionType {
    case popular
    case myList
    case recomendation
}

protocol HomeViewModelDelegate: class {
    func didSelectMovie(code: Int)
}

class HomeViewModel {

    // MARK: - Properties
    private var popular = [Movie]()
    private var myList = [Movie]()
    private var recomendation = [Movie]()
    private let movieService = MovieAPIManager()
    var coordinatorDelegate: HomeCoordinatorDelegate?
    weak var controllerDelegate: HomeViewControllerDelegate?
    let sections: [HomeSectionType] = [.popular, .myList, .recomendation]
    
    // MARK: - Configuration properties
    var numberOfSections: Int {
        return sections.count
    }
    
    var numberOfRowsBySection: Int {
        return 1
    }
    
    // MARK: - Public methods
    func isMyListEmpty() -> Bool {
        return myList.isEmpty
    }
    
    func isRecomendationEmpty() -> Bool {
        return recomendation.isEmpty
    }
    
    func recomendationsCount() -> Int {
        return 20
    }
    
    func detail(_ movieCode: Int) {
        coordinatorDelegate?.detail(movieCode)
    }
    
    func search() {
        coordinatorDelegate?.search()
    }
    
    // MARK: - Configure cell methods
    func configureCell(_ cell: PopularTableViewCell) {
        cell.delegate = self
        cell.setup(movies: popular)
    }
    
    func configureCell(_ cell: MyListTableViewCell) {
        cell.delegate = self
        cell.setup(movies: myList)
    }
    
    func configureCell(_ cell: RecomendationTableViewCell) {
        cell.delegate = self
        cell.setup(movies: recomendation)
    }
    
    // MARK: - Reload methods
    func reloadPopular() {
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
    
    func reloadMyList() {
        controllerDelegate?.myList(.loading)
        
        let movies = MovieEntity.all()
        
        if movies.isEmpty {
            self.controllerDelegate?.myList(.empty)
        } else {
            self.myList = movies
            self.controllerDelegate?.myList(.success(movies))
        }
    }
    
    // TODO: - Corrigir
    func reloadRecomendations() {
        controllerDelegate?.recomendation(.loading)
        
        let count = myList.count
        
        if count > 0 {
            let random = Int(arc4random_uniform(UInt32(count)))
            let code = myList[random].id ?? 0
            
            movieService.getRecomendationMovies(code: code) {
                switch $0 {
                case .success(let result):
                    if result.results.isEmpty {
                        self.controllerDelegate?.recomendation(.empty)
                    } else {
                        self.recomendation = result.results
                        self.controllerDelegate?.recomendation(.success(result.results))
                    }
                    
                case .error(let string):
                    self.controllerDelegate?.recomendation(.error(string))
                }
            }
        } else {
            myList = []
            controllerDelegate?.recomendation(.success([]))
        }
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    func didSelectMovie(code: Int) {
        detail(code)
    }
}
