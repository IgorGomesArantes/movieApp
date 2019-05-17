//
//  PopularCollectionViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 16/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularCollectionViewModel {
    
    // MARK: - Properties
    private let movieService = MovieAPIManager()
    private var movies: [Movie]
    
    // MARK: - Inititalization methods
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    // MARK: Public methods and properties
    var count: Int {
        return movies.count
    }
    
    func popularViewModel(cell: PopularCollectionViewCell, index: Int) {
        let movieCode = movies[index].id ?? 0
        let imagePath = movieService.getImagePath(movies[index].posterPath ?? "")
        let voteAverage = movies[index].voteAverage ?? 0.0
        
        cell.setup(movieCode: movieCode, imagePath: imagePath, voteAverage: voteAverage)
    }
}
