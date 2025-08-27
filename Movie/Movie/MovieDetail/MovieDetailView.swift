//
//  MovieDetailView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
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
            RecommendedMovieListView()
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle(movie.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

private extension MovieDetailView {
    var picture: some View {
        Group {
            if let pictureUrl = movie.detail?.picture {
                AsyncImage(url: URL(string: pictureUrl)) { image in
                    image.image?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
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
        Text(verbatim: "\(movie.year)")
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
            Text(String(movie.detail?.rating ?? 0.0))
        }
    }

    var overview: some View {
        VStack(alignment: .leading) {
            Text("Overview")
            Text(movie.detail?.description ?? "N/A")
        }
    }

    var notes: some View {
        VStack(alignment: .leading) {
            Text("Notes")
            Text(movie.detail?.notes ?? "N/A")
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(id: 1, name: "Avengers1", thumbnail: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg", year: 2019))
}
