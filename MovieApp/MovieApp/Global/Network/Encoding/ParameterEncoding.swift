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
            guard let bodyParameters = parameters.bodyParameters, let urlParameters = parameters.urlParameters else { return }
            
            try URLParameterEncoder().encode(urlRequest: &request, with: urlParameters)
            try JSONParameterEncoder().encode(urlRequest: &request, with: bodyParameters)
        } catch {
            throw error
        }
    }
}
