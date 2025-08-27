//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    @Published var detail = MovieDetail(id: 0, name: "", description: "", notes: "", rating: 0.0, picture: "", releaseDate: 0)

    init(id: Int) {
        detail = MovieDetail(id: 0, name: "avengers", description: "desc", notes: "notes", rating: 0.0, picture: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg", releaseDate: 0)
    }
}
