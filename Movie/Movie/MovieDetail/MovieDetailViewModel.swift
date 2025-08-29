//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    enum UIState {
        case initial
        case loading
        case loaded(detail: MovieDetail, recommended: [Movie])
        case error(Error)
    }

    @Published private(set) var uiState: UIState = .initial
    @Published var isShowingAlert: Bool = false

    private(set) var alertDetails = AlertDetails(title: "", message: "", buttons: [])
    private let repository: MovieRepository

    let id: Int

    init(id: Int, repository: MovieRepository = MovieRepositoryImpl()) {
        self.id = id
        self.repository = repository
    }

    func load() async {
        do {
            uiState = .loading
            let detail = try await repository.fetchMovieDetail(id: id)
            let recommended = try await repository.fetchRecommendedMovies(id: id)
            uiState = .loaded(detail: detail, recommended: recommended)
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

    func releaseDateString(from releaseDate: Int) -> String {
        // FIXME: will extract to extension
        return DateFormatter.localizedString(
            from: Date(timeIntervalSince1970: TimeInterval(releaseDate)),
            dateStyle: .medium,
            timeStyle: .none
        )
    }
}
