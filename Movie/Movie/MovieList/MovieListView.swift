//
//  MovieListView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @StateObject private var favoriteStore = FavoriteStore()

    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.uiState {
                case .initial:
                    ZStack {}
                case .loading:
                    ProgressView()
                case .loaded(let movies):
                    List(movies) { movie in
                        NavigationLink {
                            MovieDetailView(id: movie.id, favoriteStore: favoriteStore)
                        } label: {
                            MovieRowView(movie: movie, favoriteStore: favoriteStore)
                        }
                    }
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
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
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
}

#Preview {
    MovieListView()
}
