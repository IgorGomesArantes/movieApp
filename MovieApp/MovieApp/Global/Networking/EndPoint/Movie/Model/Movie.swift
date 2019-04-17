//
//  Movie.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    private var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var production_companies: [ProductionCompany]?
    var production_countries: [ProducionCountry]?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [SpokenLanguage]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
    var poster: Data?
    var creation_date: Date?
    var favorite: Bool?
}
