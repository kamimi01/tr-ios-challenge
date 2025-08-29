//
//  MovieRowViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import Foundation

final class MovieRowViewModel: ObservableObject {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}
