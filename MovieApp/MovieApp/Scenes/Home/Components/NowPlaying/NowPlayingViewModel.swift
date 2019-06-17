//
//  MyListViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 21/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class NowPlayingViewModel {
    
    // MARK: - Properties
    private let movieService = MovieAPIManager()
    private var movies = [Movie]()
    
    // MARK: Public methods and properties
    var count: Int {
        return movies.count
    }
    
    func getMovieCode(by index: Int) -> Int {
        return movies[index].id ?? 0
    }
    
    func setup(movies: [Movie]) {
        self.movies = movies
    }
    
    func configureCell(_ cell: NowPlayingCell, index: Int) {
        let imagePath = movieService.getImagePath(movies[index].posterPath ?? "")
        
        cell.setup(imagePath)
    }
}
