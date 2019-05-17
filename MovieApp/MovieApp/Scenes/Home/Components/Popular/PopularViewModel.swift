//
//  PopularCollectionViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 16/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularViewModel {
    
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
    
    func configureCell(_ cell: PopularCell, index: Int) {
        let movieCode = movies[index].id ?? 0
        let imagePath = movieService.getImagePath(movies[index].posterPath ?? "")
        let voteAverage = movies[index].voteAverage ?? 0.0
        
        cell.setup(movieCode: movieCode, imagePath: imagePath, voteAverage: voteAverage)
    }
}
