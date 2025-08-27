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
        Button(action: {
            print("recommended tapped")
        }, label: {
            VStack {
                AsyncImage(url: movie.thumbnailURL) { image in
                    image.image?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                }
                Text(movie.name)
                Text(verbatim: "\(movie.year)")
            }
        })
    }
}

#Preview {
    RecommendedMovieCardView(movie: Movie(id: 1, name: "Avengers1", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019))
}
