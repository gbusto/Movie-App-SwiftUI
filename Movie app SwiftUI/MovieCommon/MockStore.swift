//
//  MockStore.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/8/22.
//

import Foundation

struct MockStore {
    
    static var movies = [
        MovieSearchResult(
            Poster: "https://m.media-amazon.com/images/M/MV5BOTMwYjc5ZmItYTFjZC00ZGQ3LTlkNTMtMjZiNTZlMWQzNzI5XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg",
            Title: "City of God",
            Type: "Movie",
            Year: "2022",
            imdbID: "tt0317248"
        ),
        MovieSearchResult(
            Poster: "https://m.media-amazon.com/images/M/MV5BMzE5NzcxMTk5NF5BMl5BanBnXkFtZTcwNjE2MDg2OQ@@._V1_SX300.jpg",
            Title: "Only God Forgives",
            Type: "Movie",
            Year: "2022",
            imdbID: "tt1602613"
        ),
        MovieSearchResult(
            Poster: "https://m.media-amazon.com/images/M/MV5BZjcxMzk1OWMtZjIzNC00ZTYzLWFmNDktMWM2YWQ5NGI3ODU2XkEyXkFqcGdeQXVyMTA4NjE0NjEy._V1_SX300.jpg",
            Title: "God Bless America",
            Type: "Movie",
            Year: "2022",
            imdbID: "tt1912398"
        ),
    ]
}
