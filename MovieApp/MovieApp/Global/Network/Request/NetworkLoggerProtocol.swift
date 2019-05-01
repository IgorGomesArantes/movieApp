//
//  NetworkLogger.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol NetworkLoggerProtocol {
    func log(request: URLRequest)
    func log(response: URLResponse)
}
