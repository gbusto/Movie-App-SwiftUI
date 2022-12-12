//
//  Movie.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/8/22.
//

import SwiftUI
import Kingfisher

struct MovieSearchRoot: Decodable {
    var Search: [MovieSearchResult]?
}

struct MovieSearchResult: Identifiable, Decodable {
    var id: String {imdbID}
    
    var Poster: String
    var Title: String
    var `Type`: String
    var Year: String
    var imdbID: String
}

struct MovieView: View {
    let title: String
    let poster: String
    
    var body: some View {
        VStack {
            //RoundedRectangle(cornerRadius: 12).foregroundColor(.random)
            KFImage(URL(string: poster))
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .multilineTextAlignment(.center)
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(title: "Movie Name",
                  poster: "https://m.media-amazon.com/images/M/MV5BMzE5NzcxMTk5NF5BMl5BanBnXkFtZTcwNjE2MDg2OQ@@._V1_SX300.jpg")
    }
}
