//
//  MockedRequest.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum MockedRequest {
    case success
    case error
    case none
}

extension MockedRequest: RequestProtocol {
    func requestData(_ route: EndPointProtocol, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {

        switch self {
        case .success:
            let data = MockedDataHelper.getData(forResource: route.mockLocalPath)

            completion(data, URLResponse(), nil)

        case .none:
            completion(Data(), URLResponse(), nil)

        case .error:
            completion(nil, nil, NetworkError.mockedError)
        }
    }

    func cancel() {

    }
}
