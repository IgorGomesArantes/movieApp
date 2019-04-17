//
//  MovieAPIManager.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class MovieAPIManager {
    let router = NetworkRouter<MovieAPIEndPoint>()
    
    func getMovie(code: Int) {
        router.request(.movie(code: code)) { (result:ServiceResponse<Movie>) in
            
        }
    }
}
