//
//  NetworkLogger.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        debugPrint("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { debugPrint("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        debugPrint(logOutput)
    }
    
    static func log(response: URLResponse) {}
}
