//
//  MovieDetailView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel
    @ObservedObject private var favoriteStore: FavoriteStore

    init(id: Int, favoriteStore: FavoriteStore) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(id: id))
        self.favoriteStore = favoriteStore
    }

    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case .initial:
                ZStack {}
            case .loading:
                ProgressView()
            case .loaded(let detail, let recommended):
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        picture(urlString: detail.picture)
                        HStack {
                            releaseYear(releaseDate: detail.releaseDate)
                            Spacer()
                            favorite
                        }
                        rating(detail.rating)
                        overview(detail.description)
                        notes(detail.notes)
                        RecommendedMovieListView(movies: recommended)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                .navigationTitle(detail.name)
                .navigationBarTitleDisplayMode(.large)
            case .error(let error):
                ScrollView {
                    Text("Something went wrong:\n(\(error)")
                        .padding(.top, 150)
                        .frame(maxWidth: .infinity)
                        .border(.red)
                }
                .showAlert(isShowing: $viewModel.isShowingAlert, details: viewModel.alertDetails)
            }
        }
        .refreshable {
            Task {
                await viewModel.load(isRefresh: true)
            }
            favoriteStore.load()
        }
        .onAppear {
            Task {
                await viewModel.load(isRefresh: false)
            }
            favoriteStore.load()
        }
    }
}

private extension MovieDetailView {
    func picture(urlString: String) -> some View {
        Group {
            if let pictureUrl = URL(string: urlString) {
                AsyncImage(url: pictureUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 300, height: 400)
                    } else if phase.error != nil {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                    } else {
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: "movieclapper")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            }
        }
        .frame(width: 300, height: 400)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }

    func releaseYear(releaseDate: Int) -> some View {
        Text(viewModel.releaseDateString(from: releaseDate))
            .foregroundStyle(.metaText)
    }

    var favorite: some View {
        Button(action: {
            favoriteStore.toggleFavorite(viewModel.id)
        }, label: {
            Image(systemName: favoriteStore.isFavorite(viewModel.id) ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(favoriteStore.isFavorite(viewModel.id) ? .heart : .metaText)
        })
        .buttonStyle(.plain)
    }

    func rating(_ rating: Double) -> some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundStyle(.star)
            Text(String(rating))
        }
    }

    func overview(_ description: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Overview")
                .font(.title)
                .bold()
            Text(description)
        }
    }

    func notes(_ notes: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Notes")
                .font(.title)
                .bold()
            Text(notes)
        }
    }
}

#Preview {
    MovieDetailView(id: 1, favoriteStore: FavoriteStore())
}
