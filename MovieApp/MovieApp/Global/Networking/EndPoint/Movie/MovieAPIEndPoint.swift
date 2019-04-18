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
    case list(page:Int, pageSize:Int)
    case popular(page:Int, pageSize:Int)
    case recommended(page:Int, pageSize:Int, movieCodeList:[Int])
}

extension MovieAPIEndPoint: EndPointProtocol {
    
    private var environmentBaseURL: String {
        switch Configuration.shared.environment {
        case .production:
            return ""
        case .development:
            return ""
        case .staging:
            return "movieAPI"
        }
    }
    
    private var environmentAPIKey: String {
        switch Configuration.shared.environment {
        case .production:
            return ""
        case .development:
            return ""
        case .staging:
            return ""
        }
    }
    
    var baseURL: URL {
        guard let baseURL = URL(string: environmentBaseURL) else { fatalError("BaseURL could not be configured.") }
        
        return baseURL
    }
    
    var path: String {
        switch self {
        case .movie(let code):
            return "movie/\(code)"
        default:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        let task = HTTPTask.request
        
        return task
    }
    
    var headers: HTTPHeaders? {
        let headers = HTTPHeaders()
        
        return headers
    }
}
