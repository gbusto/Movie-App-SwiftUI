//
//  MovieDetailsView.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/11/22.
//

import SwiftUI
import CoreData
import Alamofire
import Kingfisher

struct MovieDetailsView: View {
    public var omdb = Omdb(apiKey: "c3bfc84")
    
    @State var moviePoster: String = ""
    @State var movieTitle: String = "N/A"
    @State var movieMetascore: String = "N/A"
    @State var moviePlot: String = "N/A"
    public var imdbID: String
        
    var body: some View {
        VStack {
            KFImage(URL(string: moviePoster))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            Text("Metacritic score: \(movieMetascore)")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            Text(moviePlot)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .task {
            omdb.getMovieDetails(imdbID: imdbID, completion: handleMovieDetailsResult(result:))
        }
    }
    
    func handleMovieDetailsResult(result: Result<MovieDetailsResult, Error>) {
        switch result {
        case .success(let details):
            moviePoster = details.Poster
            movieTitle = details.Title
            movieMetascore = details.Metascore
            moviePlot = details.Plot
        case .failure(let error):
            let err: AFError = error as! AFError
            //errorMessage = "\(String(describing: err.errorDescription))"
            print(err)
        }
    }
}


struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(imdbID: "tt1602613")
    }
}
