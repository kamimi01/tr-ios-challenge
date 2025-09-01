//
//  FavoriteStore.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import Foundation

final class FavoriteStore: ObservableObject {
    @Published private var favoriteIds: [Int] = []
    private let repository: MovieRepository

    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
        load()
    }

    func isFavorite(_ id: Int) -> Bool {
        return favoriteIds.contains(id)
    }

    func toggleFavorite(_ id: Int) {
        if isFavorite(id) {
            repository.removeFavoriteMovieId(id)
            if let index = favoriteIds.firstIndex(of: id) {
                favoriteIds.remove(at: index)
            }
        } else {
            repository.saveFavoriteMovieId(id)
            favoriteIds.append(id)
        }
    }

    func load() {
        favoriteIds = repository.fetchFavoriteMovieIds()
    }
}
