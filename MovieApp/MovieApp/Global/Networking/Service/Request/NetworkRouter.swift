//
//  NetworkRouter.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class NetworkRouter<EndPoint: EndPointProtocol> {//: NetworkRouterProtocol {
    
    // MARK: - Properties
    private let requestProtocol: RequestProtocol
    
    // MARK: - Initialization methods
    init(_ requestProtocol: RequestProtocol) {
        self.requestProtocol = requestProtocol
    }
    
    // MARK: - NetworkRouterProtocol methods
    func request<T:Decodable>(_ route: EndPoint, completion: @escaping (ServiceResponse<T>) -> ()) {
        requestProtocol.requestData(route) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    completion(.error(""))
                }
            } else {
                completion(.error(""))
            }
        }
    }
    
    func cancel() {
       requestProtocol.cancel()
    }
}

