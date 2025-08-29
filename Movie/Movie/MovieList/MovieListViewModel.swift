//
//  MovieListViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published private(set) var movies: [Movie] = []
    @Published var isShowingAlert: Bool = false
    @Published private(set) var alertDetails = AlertDetails(title: "", message: "", buttons: [])

    private(set) var favoriteMovieIds: [Int] = []

    private let client = MovieClient()

    func load() async {
        do {
            // FIXME: move to repository layer
            let request = MovieAPI.List()
            let list = try await client.send(request: request)
            self.movies = list.movies
        } catch {
            print("error loading movies: \(error)")

            let cancelButton = AlertButton(title: "Cancel", role: .cancel)
            let retryButton = AlertButton(title: "Retry", role: .destructive) { [weak self] in
                Task {
                    await self?.load()
                }
            }
            alertDetails = AlertDetails(title: "Failed to fetch movies. Do you want to retry?", message: "", buttons: [cancelButton, retryButton])
            isShowingAlert = true
        }
    }
}
