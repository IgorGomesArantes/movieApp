//
//  NetworkRouter.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class NetworkRouter<EndPoint: EndPointProtocol> {
    
    // MARK: - Properties
    private let requestProtocol: RequestProtocol
    
    // MARK: - Initialization methods
    init(requestProtocol: RequestProtocol) {
        self.requestProtocol = requestProtocol
    }
    
    // MARK: - Public methods
    func request<T:Decodable>(_ endPoint: EndPoint, completion: @escaping (ServiceResponse<T>) -> ()) {
        requestProtocol.requestData(endPoint) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 300 {
                    completion(.error("Erro: \(response.statusCode)"))
                    return
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    completion(.error("Network router decode error."))
                }
            } else if let error = error {
                completion(.error(error.localizedDescription))
                
            } else {
                completion(.error("Network router unexpected error."))
            }
        }
    }
    
    func cancel() {
       requestProtocol.cancel()
    }
}

