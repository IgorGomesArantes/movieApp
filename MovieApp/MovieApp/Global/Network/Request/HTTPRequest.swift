//
//  HTTPRequest.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class HTTPRequest: RequestProtocol {
    
    // MARK: - Properties
    var task: URLSessionTask?
    
    // MARK: - Public methods
    func requestData(_ endPoint: EndPointProtocol, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: endPoint)
            
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
            task?.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        task?.cancel()
    }
    
    // MARK: - Private methods
    private func buildRequest(from endPoint: EndPointProtocol) throws -> URLRequest {
        
        var request = URLRequest(url: endPoint.baseURL.appendingPathComponent(endPoint.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = endPoint.httpMethod.rawValue
        
        do {
            try configureParametersAndHeaders(headers: endPoint.headers, parameters: endPoint.httpParameters, request: &request)
            
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParametersAndHeaders(headers: HTTPHeaders?, parameters: HTTPParameters, request: inout URLRequest) throws {
        try ParameterEncoding.encode(parameters, request: &request)
        addAdditionalHeaders(headers, request: &request)
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
