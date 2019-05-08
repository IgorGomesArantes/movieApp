//
//  RequestProtocol.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    func requestData(_ route: EndPointProtocol, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    func cancel()
}
