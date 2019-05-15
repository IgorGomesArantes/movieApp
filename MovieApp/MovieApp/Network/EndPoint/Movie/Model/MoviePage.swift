//
//  MoviePage.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 02/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class MoviePage: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case page = "id"
        case label = "label"
        case results = "results"
        case numberOfPages = "total_pages"
        case numberOfResults = "total_results"
    }
    
    var page: Int?
    var label: String?
    var results: [Movie]
    var total_pages: Int?
    var total_results: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        label = try container.decodeIfPresent(String.self, forKey: .label)
        results = try container.decodeIfPresent([Movie].self, forKey: .results) ?? []
        total_pages = try container.decodeIfPresent(Int.self, forKey: .numberOfPages)
        total_results = try container.decodeIfPresent(Int.self, forKey: .numberOfResults)
    }
    
    init() {
        self.results = []
    }
}
