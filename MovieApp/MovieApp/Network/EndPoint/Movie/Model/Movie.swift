//
//  Movie.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class Movie: Decodable {
    var id: Int?
    var adult: Bool?
    var budget: Int?
    var revenue: Int?
    var runtime: Int?
    var title: String?
    var status: String?
    var voteCount: Int?
    var tagline: String?
    var genres: [Genre]?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var voteAverage: Float?
    var releaseDate: String?
    var originalTitle: String?
    var originalLanguage: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case budget = "budget"
        case revenue = "revenue"
        case runtime = "runtime"
        case title = "title"
        case status = "status"
        case voteCount = "vote_count"
        case tagline = "tagline"
        case genres = "genres"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        budget = try container.decodeIfPresent(Int.self, forKey: .budget)
        revenue = try container.decodeIfPresent(Int.self, forKey: .revenue)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    init() {}
}
