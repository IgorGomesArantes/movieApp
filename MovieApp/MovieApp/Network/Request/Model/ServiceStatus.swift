//
//  ServiceStatus.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum ServiceStatus<Result:Decodable> {
    case success(Result)
    case error(String)
    case empty
    case loading
}
