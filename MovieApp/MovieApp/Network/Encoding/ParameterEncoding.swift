//
//  ParametersEncoding.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class ParameterEncoding {
    static func encode(_ parameters: HTTPParameters, request: inout URLRequest) throws {
        do {
            if let bodyParameters = parameters.bodyParameters {
                try JSONParameterEncoder().encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = parameters.urlParameters {
                try URLParameterEncoder().encode(urlRequest: &request, with: urlParameters)
            }
            
        } catch {
            throw error
        }
    }
}
