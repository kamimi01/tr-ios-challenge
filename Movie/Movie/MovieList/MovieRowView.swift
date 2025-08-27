//
//  MovieRowView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 15) {
            Group {
                if let thumbnailUrl = URL(string: movie.thumbnail) {
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
                Text(movie.name)
                Text("(\(movie.year))")
            }

            Spacer()

            Button(action: {
                print("heart tapped")
            }, label: {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            })
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    MovieRowView(movie: Movie(id: 1, name: "avengers", thumbnail: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg", year: 1990))
}
