//
//  MovieAPIManager.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class MovieAPIManager {
    
    // MARK: - Properties
    private let router: NetworkRouter<MovieAPIEndPoint>
    
    // MARK: - Initialization methods
    init(_ requestProtocol: RequestProtocol) {
        router = NetworkRouter<MovieAPIEndPoint>(requestProtocol)
    }
    
    // MARK: - Public methods
    func getMovie(code: Int, completion: @escaping (ServiceResponse<Movie>) -> ()) {
        router.request(.movie(code: code)) {
            completion($0)
        }
    }
    
    func getPopularMovies(page:Int, pageSize:Int, completion: @escaping (ServiceResponse<[Movie]>) -> ()) {
        router.request(.popular(page: page, pageSize: pageSize)) {
            completion($0)
        }
    }
}
