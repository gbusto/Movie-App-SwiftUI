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
    var bottom: CGFloat = .zero
    
    private var omdb = Omdb(apiKey: "c3bfc84")
    
    @State private var searchText = ""
    
    // The list of movies to show in the search results view
    @State private var movies: [MovieSearchResult] = []
    
    @State private var errorMessage: String = ""
    
    // A state variable to help with pagination
    @State private var showLoadMoreButton: Bool = false

    // Used to indicate when we are loading data (i.e. making a call to Omdb)
    @State private var loading: Bool = false

    // Used by the LazyVGrid for loading movie search results
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

                if loading {
                    LoadingView()
                }

                if showLoadMoreButton {
                    // Should show only where there are movie search results, and there are still
                    // more results to pull down.
                    Button("Load more movies", action: getMoreSearchResults)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search for movies")
        .onSubmit(of: .search) {
            getSearchResults()
        }
    }
    
    func getSearchResults() {
        let movie = $searchText.wrappedValue

        // Reset our Omdb instance:
        // - the search text
        // - its current page in pagination
        // - indicator saying whether or not we've reached the last page
        omdb.reset()

        omdb.movieToSearch = movie
        omdb.searchForMovie(completion: updateMovieResults(result:))
        loading = true
    }

    func getMoreSearchResults() {
        omdb.searchForMovie(page: omdb.getNextPage(),
                            completion: appendMovieResults(result:))
    }
    
    func updateMovieResults(result: Result<[MovieSearchResult], Error>) {
        switch result {
        case .success(let _movies):
            movies = _movies
            if movies.isEmpty {
                errorMessage = "No results found"
                showLoadMoreButton = false
            }
            else {
                errorMessage = ""
                showLoadMoreButton = true
            }

        case .failure(let error):
            let err: AFError = error as! AFError
            movies = []
            // TODO - Improve the way this error is printed on screen
            errorMessage = "\(String(describing: err.errorDescription))"
            print(error)
        }

        loading = false
    }

    func appendMovieResults(result: Result<[MovieSearchResult], Error>) {
        switch result {
        case .success(let _movies):
            movies += _movies
            if omdb.reachedLastPage {
                // This means there are no more search results for the given title
                showLoadMoreButton = false
            }
            
        case .failure(let error):
            let err: AFError = error as! AFError
            movies = []
            errorMessage = "\(String(describing: err.errorDescription))"
            print(error)
        }

        loading = false
    }
}


struct LoadingView: View {
    var tintColor: Color = .gray
    var scaleSize: CGFloat = 2.0
    var loadingText: String = "Getting data..."

    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
            .padding()
        Text(loadingText)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
