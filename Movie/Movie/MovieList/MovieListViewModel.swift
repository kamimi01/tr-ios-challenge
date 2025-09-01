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
    private let repository: MovieRepository

    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
    }

    func load(isRefresh: Bool) async {
        do {
            uiState = .loading
            let movies = try await repository.fetchMovies(cachePolicy: isRefresh ? .reloadRevalidatingCacheData : .returnCacheDataElseLoad)
            uiState = .loaded(movies)
        } catch {
            print("error loading movies: \(error)")
            uiState = .error(error)

            let cancelButton = AlertButton(title: "Cancel", role: .cancel)
            let retryButton = AlertButton(title: "Retry", role: .destructive) { [weak self] in
                Task {
                    await self?.load(isRefresh: isRefresh)
                }
            }
            alertDetails = AlertDetails(title: "Failed to fetch movies. Do you want to retry?", message: "", buttons: [cancelButton, retryButton])
            isShowingAlert = true
        }
    }
}
