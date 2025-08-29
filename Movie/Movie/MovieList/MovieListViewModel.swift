//
//  MovieListViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private(set) var favoriteMovieIds: [Int] = []

    private let client = MovieClient()

    func load() async {
        do {
            // FIXME: move to repository layer
            let request = MovieAPI.List()
            let list = try await client.send(request: request)
            self.movies = list.movies
        } catch {
            // FIXME: show error
        }
    }
}
