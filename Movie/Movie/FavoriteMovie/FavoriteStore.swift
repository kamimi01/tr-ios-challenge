//
//  FavoriteStore.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import Foundation

final class FavoriteStore: ObservableObject {
    @Published private(set) var favoriteIds: [Int] = []

    init() {
        load()
    }

    func isFavorite(_ id: Int) -> Bool {
        return favoriteIds.contains(id)
    }

    func toggleFavorite(_ id: Int) {
        if let index = favoriteIds.firstIndex(of: id) {
            favoriteIds.remove(at: index)
        } else {
            favoriteIds.append(id)
        }

        UserDefaults.standard.set(favoriteIds, forKey: Constants.UserDefaultsKey.favoriteMovies)
    }

    func load() {
        favoriteIds = UserDefaults.standard.array(forKey: Constants.UserDefaultsKey.favoriteMovies) as? [Int] ?? []
    }
}
