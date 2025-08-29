//
//  MovieRowView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct MovieRowView: View {
    @StateObject private var viewModel: MovieRowViewModel

    init(movie: Movie, favoriteMovieIds: [Int]) {
        _viewModel = StateObject(wrappedValue: MovieRowViewModel(movie: movie, favoriteMovieIds: favoriteMovieIds))
    }

    var body: some View {
        HStack(spacing: 15) {
            Group {
                if let thumbnailUrl = URL(string: viewModel.movie.thumbnail) {
                    AsyncImage(url: thumbnailUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
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
            .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.movie.name)
                    .font(.body)
                Text(verbatim: "(\(viewModel.movie.year))")
                    .font(.caption)
                    .foregroundStyle(.metaText)
            }

            Spacer()

            Button(action: {
                viewModel.toggleFavorite()
            }, label: {
                if viewModel.isFavorite {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.heart)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            })
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    MovieRowView(movie: Movie(id: 0, name: "avengers", thumbnail: "", year: 1990), favoriteMovieIds: [])
}
