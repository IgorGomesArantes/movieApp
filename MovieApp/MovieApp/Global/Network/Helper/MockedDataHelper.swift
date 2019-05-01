//
//  MockedDataHelper.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class MockDataHelper {
    static func getData(forResource resource: String) -> Data {
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: resource, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("Resource not found")
        }
        
        return data
    }
}
