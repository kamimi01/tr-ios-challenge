//
//  RecommendedMovieCardView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct RecommendedMovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack {
            Group {
                if let thumbnailURL = URL(string: movie.thumbnail) {
                    AsyncImage(url: thumbnailURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
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

            Text(movie.name)
            Text(verbatim: "\(movie.year)")
        }
    }
}

#Preview {
    RecommendedMovieCardView(movie: Movie(id: 1, name: "Avengers1", thumbnail: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg", year: 2019))
}
