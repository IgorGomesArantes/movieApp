//
//  MovieAPIEndPoint.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

// TODO: - Colocar os valores corretos
import Foundation

enum MovieAPIEndPoint {
    case movie(code:Int)
    case popular(page:Int, pageSize:Int)
}

// MARK: - Constants
extension MovieAPIEndPoint {
    private var apiKey: String {
        return "423a7efcc5851107f96bc25a3b0c3f28"
    }
    
    private var language: String {
        return "pt-BR"
    }
    
    var imageBaseURL: String {
        return "https://image.tmdb.org/t/p"
    }
}

extension MovieAPIEndPoint: EndPointProtocol {

    private var environmentBaseURL: String {
        switch Configuration.shared.environment {
        case .production:
            return "https://api.themoviedb.org/3"
        case .staging:
            return "MockedMovieAPI"
        }
    }
    
    var baseURL: URL {
        guard let baseURL = URL(string: environmentBaseURL) else { fatalError("BaseURL could not be configured.") }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .movie(let code):
            return "movie\(code)"
            
        case .popular:
            return "movie/popular"
        }
    }
    
    var mockLocalPath: String {
        switch self {
        case .movie:
            return "movie"
            
        case .popular:
            return "popular"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    // TODO: - Adicionar parametros de chave e linguagem
    var httpParameters: HTTPParameters {
        switch self {
        case .movie(let code):
            let parameters = ["id": String(code), "api_key": apiKey, "language": language]
            return HTTPParameters(bodyParameters: nil, urlParameters: parameters)
        
        case .popular:
            let parameters = ["api_key": apiKey, "language": language]
            return HTTPParameters(bodyParameters: nil, urlParameters: parameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
