//
//  RecomendationViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 21/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class TopRatedViewModel {
    
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
    
    func configureCell(_ cell: RecomendationCell, index: Int) {
        let imagePath = movieService.getImagePath(movies[index].posterPath ?? "")
        let movieCode = movies[index].id ?? 0
        let voteAverare = movies[index].voteAverage ?? 0
        let title = movies[index].title ?? ""
        
        cell.setup(movieCode: movieCode, imagePath: imagePath, voteAverage: voteAverare, title: title)
    }
}
