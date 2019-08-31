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
    private let imageBaseURL = "https://image.tmdb.org/t/p"
    
    // TODO: - Injeção de dependencias
    // MARK: - Initialization methods
    init() {
        switch Configuration.shared.environment {
        case .production:
            router = NetworkRouter<MovieAPIEndPoint>(requestProtocol: HTTPRequest())
        case .staging:
            router = NetworkRouter<MovieAPIEndPoint>(requestProtocol: MockedRequest.success)
        }
    }
    
    // MARK: - Public methods
    func getMovie(by code: Int, completion: @escaping (ServiceResponse<Movie>) -> ()) {
        router.request(.movie(code: code)) {
            completion($0)
        }
    }
    
    func getMovies(by query: String, completion: @escaping (ServiceResponse<MoviePage>) -> ()) {
        router.request(.search(query: query)) {
            completion($0)
        }
    }
    
    func getPopularMovies(completion: @escaping (ServiceResponse<MoviePage>) -> ()) {
        router.request(.popular) {
            completion($0)
        }
    }
    
    func getSimilarMovies(code: Int, completion: @escaping (ServiceResponse<MoviePage>) -> ()) {
        router.request(.similar(code: code)) {
            completion($0)
        }
    }
    
    func getTopRatedMovies(completion: @escaping (ServiceResponse<MoviePage>) -> ()) {
        router.request(.topRated) {
            completion($0)
        }
    }
    
    func getNowPlayingMovies(completion: @escaping (ServiceResponse<MoviePage>) -> ()) {
        router.request(.nowPlaying) {
            completion($0)
        }
    }
    
    func getImagePath(_ imagePath: String, quality: Quality = Quality.medium) -> String {
        return "\(imageBaseURL)/\(quality.rawValue)/\(imagePath)"
    }
}
