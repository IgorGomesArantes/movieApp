//
//  Movie.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int?
    var adult: Bool?
    var budget: Int?
    var video: Bool?
    var poster: Data?
    var revenue: Int?
    var runtime: Int?
    var title: String?
    var status: String?
    var favorite: Bool?
    var vote_count: Int?
    var tagline: String?
    var genres: [Genre]?
    var imdb_id: String?
    var overview: String?
    var homepage: String?
    var popularity: Float?
    var creation_date: Date?
    var poster_path: String?
    var vote_average: Float?
    var release_date: String?
    var backdrop_path: String?
    var original_title: String?
    var original_language: String?
    var spoken_languages: [SpokenLanguage]?
    var production_countries: [ProducionCountry]?
    var production_companies: [ProductionCompany]?
}
