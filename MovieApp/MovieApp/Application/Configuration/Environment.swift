//
//  Environment.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 16/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

public enum PlistKey {
    case environment
    
    func value() -> String {
        switch self {
        case .environment:
            return "Environment"
        }
    }
}

public struct Environment {
    
    func configuration(_ key: PlistKey) -> String {
        switch key {
        case .environment:
            return infoDictionary[PlistKey.environment.value()] as! String
        }
    }
    
    private var infoDictionary: [String: Any]  {
        get {
            if let dictionary = Bundle.main.infoDictionary {
                return dictionary
            }else {
                fatalError("Plist file not found")
            }
        }
    }
}
