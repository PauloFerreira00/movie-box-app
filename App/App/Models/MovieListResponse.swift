//
//  MovieListResponse.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 24/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

struct MovieListResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
