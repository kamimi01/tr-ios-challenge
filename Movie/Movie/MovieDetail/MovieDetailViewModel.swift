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

    private let id: Int
    private let client = MovieClient()

    init(id: Int) {
        self.id = id
    }

    func load() async {
        do {
            try await loadDetail()
            try await loadRecommendedMovie()
        } catch {
            // FIXME: show an error
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
