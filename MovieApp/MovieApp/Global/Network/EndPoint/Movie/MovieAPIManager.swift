//
//  MovieAPIManager.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class MovieAPIManager {
    private let router: NetworkRouter<MovieAPIEndPoint>
    
    init(_ requestProtocol: RequestProtocol) {
        router = NetworkRouter<MovieAPIEndPoint>(requestProtocol)
    }
    
    func getMovie(code: Int, completion: @escaping (ServiceResponse<Movie>) -> ()) {
        router.request(.movie(code: code)) { (result:ServiceResponse<Movie>) in
            completion(result)
        }
    }
}
