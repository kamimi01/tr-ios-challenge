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

    let id: Int
    private let client = MovieClient()

    init(id: Int) {
        self.id = id
    }

    func load() async {
        do {
            uiState = .loading
            let detail = try await loadDetail()
            let recommended = try await loadRecommendedMovie()
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

    private func loadDetail() async throws -> MovieDetail {
        let detailRequest = MovieAPI.Detail(id: id)
        return try await client.send(request: detailRequest)
    }

    private func loadRecommendedMovie() async throws -> [Movie] {
        let recommendedRequest = MovieAPI.Recommend(id: id)
        let recommendedList = try await client.send(request: recommendedRequest)
        return recommendedList.movies
    }
}
