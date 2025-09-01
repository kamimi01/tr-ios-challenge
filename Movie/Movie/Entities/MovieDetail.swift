//
//  MovieDetail.swift
//  Movie
//
//  Created by mika_admin on 2025-09-01.
//

struct MovieDetail: Codable {
    let id: Int
    let name: String
    let description: String
    let notes: String
    let rating: Double
    let picture: String
    let releaseDate: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "Description"
        case notes = "Notes"
        case rating = "Rating"
        case picture
        case releaseDate
    }
}
