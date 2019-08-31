//
//  ServiceStatus.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum ServiceStatus: Equatable {
    static func == (lhs: ServiceStatus, rhs: ServiceStatus) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success), (.empty, .empty), (.loading, .loading), (.error, .error):
            return true
        default:
            return false
        }
    }
    
    case success
    case error(String)
    case empty
    case loading
}
