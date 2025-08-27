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
                        .scaledToFill()
                        .frame(width: 300, height: 300)
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
        .frame(width: 300, height: 300)
        .padding(.horizontal, 16)
        .border(.gray)
        .frame(maxWidth: .infinity)
    }

    var releaseYear: some View {
        Text(verbatim: "\(viewModel.detail.releaseDate)")
    }

    var favorite: some View {
        Image(systemName: "heart")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
    }

    var rating: some View {
        HStack(spacing: 5) {
            HStack(spacing: 0) {
                ForEach(0..<10) { _ in
                    Image(systemName: "star")
                }
            }
            Text(String(viewModel.detail.rating))
        }
    }

    var overview: some View {
        VStack(alignment: .leading) {
            Text("Overview")
            Text(viewModel.detail.description)
        }
    }

    var notes: some View {
        VStack(alignment: .leading) {
            Text("Notes")
            Text(viewModel.detail.notes)
        }
    }
}

#Preview {
    MovieDetailView(id: 1)
}
