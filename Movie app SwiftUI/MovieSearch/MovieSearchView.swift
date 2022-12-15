//
//  ContentView.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/7/22.
//

import SwiftUI
import CoreData
import Alamofire
import Omdb

struct MovieSearchView: View {
    let itemsPerRow: CGFloat = 3
    let horizontalSpacing: CGFloat = 10
    let height: CGFloat = 200
    var bottom: CGFloat = .zero
    
    static var DARK_MODE_STR: String = "Dark Mode"
    static var LIGHT_MODE_STR: String = "Light Mode"
    
    private var omdb = Omdb(apiKey: "c3bfc84")
    
    @AppStorage("DarkMode") private var darkMode: Bool = false
    
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
            ZStack {
                Color(darkMode ? .black : .white).edgesIgnoringSafeArea(.all)
                
                Text(errorMessage)
                    .foregroundColor(darkMode ? .white : .black)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(movies) { movie in
                            NavigationLink(destination: MovieDetailsView(imdbID: movie.imdbID)) {
                                MovieView(title: movie.Title,
                                          poster: movie.Poster,
                                          textColor: darkMode ? .white : .black)
                            }
                        }
                    }
                    .padding()
                    
                    if loading {
                        LoadingView(tintColor: darkMode ? .white : .gray)
                    }
                    
                    if showLoadMoreButton {
                        // Should show only where there are movie search results, and there are still
                        // more results to pull down.
                        Button("Load more movies", action: getMoreSearchResults)
                            .foregroundColor(.blue)
                    }
                }
                
                .toolbar {
                    ToolbarItem {
                        Button(darkMode ? "Light Mode" : "Dark Mode", action: switchViewMode)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search for movies")
        .foregroundColor(darkMode ? .white : .black)
        .onSubmit(of: .search) {
            getSearchResults()
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }
    
    func switchViewMode() {
        darkMode = !darkMode
    }
    
    func getSearchResults() {
        let movie = $searchText.wrappedValue

        // Reset our Omdb instance:
        // - the search text
        // - its current page in pagination
        // - indicator saying whether or not we've reached the last page
        omdb.reset()

        omdb.movieToSearch = movie
        omdb.getNextSearchResults(completion: updateMovieResults(result:))
        loading = true
    }

    func getMoreSearchResults() {
        omdb.getNextSearchResults(completion: appendMovieResults(result:))
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


struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
