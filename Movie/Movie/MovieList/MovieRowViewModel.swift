//
//  MovieRowViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import Foundation
import SwiftUI

final class MovieRowViewModel: ObservableObject {
    @Published private(set) var isFavorite: Bool = false
    let movie: Movie

    init(movie: Movie, favoriteMovieIds: [Int]) {
        self.movie = movie
        isFavorite = favoriteMovieIds.contains(movie.id)
    }

    func toggleFavorite() {
        if isFavorite {
            removeFavoriteId(movie.id)
        } else {
            saveFavoriteId(movie.id)
        }
        isFavorite.toggle()
    }

    // FIXME: will move to repository layer later.
    private func saveFavoriteId(_ id: Int) {
        var favoriteIds: [Int] = UserDefaults.standard.array(forKey: Constants.UserDefaultsKey.favoriteMovies) as? [Int] ?? []
        favoriteIds.append(id)

        UserDefaults.standard.set(favoriteIds, forKey: Constants.UserDefaultsKey.favoriteMovies)
    }

    private func removeFavoriteId(_ id: Int) {
        var favoriteIds: [Int] = UserDefaults.standard.array(forKey: Constants.UserDefaultsKey.favoriteMovies) as? [Int] ?? []
        favoriteIds.removeAll { $0 == id }

        UserDefaults.standard.set(favoriteIds, forKey: Constants.UserDefaultsKey.favoriteMovies)
    }
}
