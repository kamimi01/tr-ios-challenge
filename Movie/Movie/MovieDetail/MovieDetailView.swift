//
//  MovieDetailView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject private var viewModel: MovieDetailViewModel

    init(id: Int) {
        self.viewModel = MovieDetailViewModel(id: id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                picture
                HStack {
                    releaseYear
                    Spacer()
                    favorite
                }
                rating
                overview
                notes
                RecommendedMovieListView(movies: viewModel.recommendedMovies)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(viewModel.detail.name)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}

private extension MovieDetailView {
    var picture: some View {
        Group {
            if let pictureUrl = URL(string: viewModel.detail.picture) {
                AsyncImage(url: pictureUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 300, height: 400)
                } placeholder: {
                    ProgressView()
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

    var releaseYear: some View {
        Text(viewModel.releaseDateString())
            .foregroundStyle(.metaText)
    }

    var favorite: some View {
        Image(systemName: "heart")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
    }

    var rating: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundStyle(.star)
            Text(String(viewModel.detail.rating))
        }
    }

    var overview: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Overview")
                .font(.title)
                .bold()
            Text(viewModel.detail.description)
        }
    }

    var notes: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Notes")
                .font(.title)
                .bold()
            Text(viewModel.detail.notes)
        }
    }
}

#Preview {
    MovieDetailView(id: 1)
}
