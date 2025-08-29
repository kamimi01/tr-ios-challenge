//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published var detail = MovieDetail(id: 0, name: "", description: "", notes: "", rating: 0.0, picture: "", releaseDate: 0)
    @Published var recommendedMovies: [Movie] = []
    @Published var isShowingAlert: Bool = false
    @Published private(set) var alertDetails = AlertDetails(title: "", message: "", buttons: [])

    let id: Int
    private let client = MovieClient()

    init(id: Int) {
        self.id = id
    }

    func load() async {
        do {
            try await loadDetail()
            try await loadRecommendedMovie()
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

    func releaseDateString() -> String {
        return DateFormatter.localizedString(
            from: Date(timeIntervalSince1970: TimeInterval(detail.releaseDate)),
            dateStyle: .medium,
            timeStyle: .none
        )
    }

    private func loadDetail() async throws {
        let detailRequest = MovieAPI.Detail(id: id)
        self.detail = try await client.send(request: detailRequest)
    }

    private func loadRecommendedMovie() async throws {
        let recommendedRequest = MovieAPI.Recommend(id: id)
        let recommendedList = try await client.send(request: recommendedRequest)
        self.recommendedMovies = recommendedList.movies
    }
}
