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
    
    // MARK: - Metadata
    enum SectionStyle {
        case popular
        case topRated
        case nowPlaying
    }

    // MARK: - Properties
    private var popular = [Movie]()
    private var topRated = [Movie]()
    private var nowPlaying = [Movie]()
    private let movieService = MovieAPIManager()
    var coordinatorDelegate: HomeCoordinatorDelegate?
    weak var controllerDelegate: HomeViewControllerDelegate?
    let sections: [SectionStyle] = [.popular, .nowPlaying, .topRated]
    
    // MARK: - Reload methods
    func reloadAll() {
        reloadPopular()
        reloadNowPlaying()
        reloadTopRated()
    }
    
    private func reloadPopular() {
        controllerDelegate?.popular(.loading)
        
        movieService.getPopularMovies() {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.controllerDelegate?.popular(.empty)
                } else {
                    self.popular = result.results
                    self.controllerDelegate?.popular(.success)
                }
                
            case .error(let string):
                self.controllerDelegate?.popular(.error(string))
            }
        }
    }
    
    private func reloadTopRated() {
        controllerDelegate?.topRated(.loading)
        
        movieService.getTopRatedMovies() {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.controllerDelegate?.topRated(.empty)
                } else {
                    self.topRated = result.results
                    self.controllerDelegate?.topRated(.success)
                }
                
            case .error(let string):
                self.controllerDelegate?.topRated(.error(string))
            }
        }
    }
    
    private func reloadNowPlaying() {
        controllerDelegate?.nowPlaying(.loading)
        
        movieService.getNowPlayingMovies() {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.controllerDelegate?.nowPlaying(.empty)
                } else {
                    self.nowPlaying = result.results
                    self.controllerDelegate?.nowPlaying(.success)
                }
                
            case .error(let string):
                self.controllerDelegate?.nowPlaying(.error(string))
            }
        }
    }
    
    // MARK: - Configure methods
    func configureHeader(_ header: HomeTableSectionHeaderView, section: Int) {
        let sectionStyle = sections[section]
        
        switch sectionStyle {
        case .popular:
            header.titleLabel.text = "Melhores da semana"
        case .topRated:
            header.titleLabel.text = "Melhores de todos os tempos"
        case .nowPlaying:
            header.titleLabel.text = "Agora nos cinemas"
        }
    }
    
    func configureCell(_ cell: PopularTableViewCell) {
        cell.delegate = self
        cell.setup(movies: popular)
    }
    
    func configureCell(_ cell: NowPlayingTableViewCell) {
        cell.delegate = self
        cell.setup(movies: nowPlaying)
    }
    
    func configureCell(_ cell: TopRatedTableViewCell) {
        cell.delegate = self
        cell.setup(movies: topRated)
    }
    
    // MARK: - Navigation methods
    func detail(_ movieCode: Int) {
        coordinatorDelegate?.detail(movieCode)
    }
    
    func search() {
        coordinatorDelegate?.search()
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    func didSelectMovie(code: Int) {
        detail(code)
    }
}
