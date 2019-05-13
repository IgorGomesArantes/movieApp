//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    // MARK: - Properties
    var movie: Movie = Movie()
    let movieService = MovieAPIManager()
    
    // MARK: - Initialization methods
    init() {
        
    }
}
