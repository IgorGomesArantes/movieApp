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
    private var task: URLSessionTask?
    
    // MARK: - NetworkRouterProtocol methods
    func request<Response:Decodable>(_ route: EndPoint, completion: @escaping (ServiceResponse<Response>) -> ()) {
        
        do {
            let request = try buildRequest(from: route)
            NetworkLogger.log(request: request)
            getDataFromUrl(request: request){ (data, response, error) in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(Response.self, from: data)
                        
                        completion(.success(decodedData))
                    } catch {
                        completion(.error(""))
                    }
                } else {
                    completion(.error(""))
                }
            }
        } catch {
            completion(.error(""))
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private methods
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
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
    
    private func getDataFromUrl(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?)->()) {
        let session = URLSession.shared
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        task?.resume()
    }
    
    private func getData<T:Decodable>(request: URLRequest, completion: @escaping(ServiceResponse<T>) -> ()) {
        getDataFromUrl(request: request){ (data, response, error) in
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

