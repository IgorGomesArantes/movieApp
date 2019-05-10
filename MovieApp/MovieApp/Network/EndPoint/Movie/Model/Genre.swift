//
//  Genre.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class Genre: Decodable {
    let code: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "id"
        case name = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decodeIfPresent(Int.self, forKey: .code)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}
