//
//  Movie.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import Foundation

struct Movie: Identifiable, Hashable {
    let id: Int
    let name: String
    let thumbnailURL: URL?
    let year: Int
    let detail: Detail? = nil
    let recommendations: [Movie]? = nil

    struct Detail: Equatable, Hashable {
        let description: String
        let notes: String
        let rating: Double
        let pictureURL: URL?
        let releaseDate: Int
    }
}
