//
//  Movie.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

struct Movie: Identifiable, Hashable {
    let id: Int
    let name: String
    let thumbnail: String
    let year: Int
    let detail: Detail? = nil

    struct Detail: Equatable, Hashable {
        let description: String
        let notes: String
        let rating: Double
        let picture: String
        let releaseDate: Int
    }
}
