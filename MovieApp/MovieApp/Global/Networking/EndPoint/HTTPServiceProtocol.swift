//
//  HTTPServiceProtocol.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HTTPServiceProtocol {
    var sessionConfiguration: URLSessionConfiguration { get set }
}

extension HTTPServiceProtocol {
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession(configuration: sessionConfiguration)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async() {
                completion(data, response, error)
            }
        }
        task.resume()
    }
    
    private func getData<T:Decodable>(url:URL, completion: @escaping(ServiceResponse<T>) -> ()) {
        getDataFromUrl(url: url){ (data, response, error) in
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
}
