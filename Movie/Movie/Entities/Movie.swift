//
//  Movie.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

struct Movie: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let thumbnail: String
    let year: Int
}
