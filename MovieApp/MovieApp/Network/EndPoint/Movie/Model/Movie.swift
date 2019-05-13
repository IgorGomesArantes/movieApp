//
//  Movie.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let id: Int?
    let adult: Bool?
    let budget: Int?
    let revenue: Int?
    let runtime: Int?
    let title: String?
    let status: String?
    let vote_count: Int?
    let tagline: String?
    let genres: [Genre]?
    let overview: String?
    let popularity: Float?
    let posterPath: String?
    let voteAverage: Float?
    let releaseDate: String?
    let originalTitle: String?
    let originalLanguage: String?
    
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
        vote_count = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        genres = try container.decodeIfPresent([Genre].self, forKey: .tagline)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    init() {
        id = nil
        adult = nil
        budget = nil
        revenue = nil
        runtime = nil
        title = nil
        status = nil
        vote_count = nil
        tagline = nil
        genres = nil
        overview = nil
        popularity = nil
        posterPath = nil
        voteAverage = nil
        releaseDate = nil
        originalTitle = nil
        originalLanguage = nil
    }
}
