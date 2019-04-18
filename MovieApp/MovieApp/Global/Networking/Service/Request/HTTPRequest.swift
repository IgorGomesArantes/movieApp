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
    func requestData(_ route: EndPointProtocol, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            
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
    private func buildRequest(from route: EndPointProtocol) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(
                let bodyParameters,
                let bodyEncoding,
                let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(
                let bodyParameters,
                let bodyEncoding,
                let urlParameters,
                let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(   bodyParameters: Parameters?,
                                        bodyEncoding: ParameterEncoding,
                                        urlParameters: Parameters?,
                                        request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
