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
    
    let page: Int?
    let label: String?
    let results: [Movie]
    let total_pages: Int?
    let total_results: Int?
    
    init() {
        self.page = 1
        self.label = nil
        self.results = []
        self.total_pages = 1
        self.total_results = 0
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        label = try container.decodeIfPresent(String.self, forKey: .label)
        results = try container.decodeIfPresent([Movie].self, forKey: .results) ?? []
        total_pages = try container.decodeIfPresent(Int.self, forKey: .numberOfPages)
        total_results = try container.decodeIfPresent(Int.self, forKey: .numberOfResults)
    }
}
