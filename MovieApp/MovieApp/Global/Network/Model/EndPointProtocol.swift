//
//  EndPointProtocol.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var httpMethod: HTTPMethod { get }
    var httpParameters: HTTPParameters { get }
}

