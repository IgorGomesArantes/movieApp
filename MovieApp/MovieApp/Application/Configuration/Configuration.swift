//
//  Environment.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 16/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum Environment: String {
    case production = "PRODUCTION"
    case staging = "STAGING"
}

struct Configuration {
    
    private init() {}
    
    static let shared = Configuration()
    
    var environment: Environment {
        guard let environmentKey = infoDictionary["Environment"] as? String,
            let environment = Environment(rawValue: environmentKey)
            else { return .staging }
        
        return environment
    }
    
    private var infoDictionary: [String: Any]  {
        get {
            if let dictionary = Bundle.main.infoDictionary {
                return dictionary
            }else {
                fatalError("Plist file not found")
            }
        }
    }
}
