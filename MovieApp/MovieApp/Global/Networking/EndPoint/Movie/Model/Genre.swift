//
//  Genre.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int?
    var name: String?
    
    init() {
        id = 0
        name = "Genero"
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
