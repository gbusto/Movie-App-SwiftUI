//
//  ContentView.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/7/22.
//

import SwiftUI
import CoreData
import Alamofire

struct ContentView: View {
    let itemsPerRow: CGFloat = 3
    let horizontalSpacing: CGFloat = 10
    let height: CGFloat = 200
    
    private var omdb = Omdb(apiKey: "c3bfc84")
    
    @State private var searchText = ""
    
    @State private var movies: [MovieSearchResult] = []
    
    @State private var errorMessage: String = ""
    
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]
        
    var body: some View {
        NavigationStack {
            Text(errorMessage)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailsView(imdbID: movie.imdbID)) {
                            MovieView(title: movie.Title, poster: movie.Poster)
                        }
                    }
                }
                .padding()
            }
        }
        .searchable(text: $searchText, prompt: "Search for movies")
        .onSubmit(of: .search) {
            getSearchResults()
        }
    }
    
    func getSearchResults() {
        let movie = $searchText.wrappedValue
        print("You searched for: \(movie)")
        omdb.searchForMovie(title: movie, completion: updateMovieResults(result:))
    }
    
    func updateMovieResults(result: Result<[MovieSearchResult], Error>) {
        switch result {
        case .success(let _movies):
            movies = _movies
            if movies.isEmpty {
                errorMessage = "No results found"
            }
            else {
                errorMessage = ""
            }
            
        case .failure(let error):
            let err: AFError = error as! AFError
            movies = []
            errorMessage = "\(String(describing: err.errorDescription))"
            print(error)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
