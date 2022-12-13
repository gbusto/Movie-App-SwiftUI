//
//  Movie.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/8/22.
//

import SwiftUI
import Kingfisher

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
                .foregroundColor(.black)
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(title: "Movie Name",
                  poster: "https://m.media-amazon.com/images/M/MV5BMzE5NzcxMTk5NF5BMl5BanBnXkFtZTcwNjE2MDg2OQ@@._V1_SX300.jpg")
    }
}
