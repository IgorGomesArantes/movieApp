//
//  MoviePage.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 02/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

struct MoviePage: Decodable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var label: String?
    var results: [Movie]
    
    init() {
        page = 1
        total_results = 0
        total_pages = 1
        results = [Movie]()
    }
}
