//
//  MovieListViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    enum UIState {
        case initial
        case loading
        case loaded([Movie])
        case error(Error)
    }

    @Published private(set) var uiState: UIState = .initial
    @Published var isShowingAlert: Bool = false
    private(set) var alertDetails = AlertDetails(title: "", message: "", buttons: [])

    private(set) var favoriteMovieIds: [Int] = []

    private let client = MovieClient()

    func load() async {
        do {
            // FIXME: move to repository layer
            uiState = .loading
            let request = MovieAPI.List()
            let list = try await client.send(request: request)
            uiState = .loaded(list.movies)
        } catch {
            print("error loading movies: \(error)")
            uiState = .error(error)

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
