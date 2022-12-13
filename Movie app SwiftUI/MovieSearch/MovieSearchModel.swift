//
//  MovieSearchModel.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/13/22.
//

import Foundation

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
