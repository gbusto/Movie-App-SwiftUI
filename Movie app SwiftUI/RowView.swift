//
//  RowView.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/8/22.
//

import SwiftUI

struct RowView: View {
    let movies: [MovieSearchResult]
    let horizontalSpacing: CGFloat
    
    var body: some View {
        HStack(alignment: .top, spacing: horizontalSpacing) {
            ForEach(movies) { movie in
                MovieView(title: movie.Title,
                          poster: movie.Poster)
            }
        }
        .padding()
    }
}
