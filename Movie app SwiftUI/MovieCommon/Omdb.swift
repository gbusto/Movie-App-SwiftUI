//
//  Omdb.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/10/22.
//

import Foundation
import Alamofire

class Omdb {
    
    var apiKey: String
    var movieToSearch: String = ""
    var reachedLastPage: Bool = false
    private var page: Int = 1
    static private var MAX_RESULTS_PER_SEARCH: Int = 10
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func reset() {
        movieToSearch = ""
        reachedLastPage = false
        page = 1
    }

    func getNextPage() -> Int {
        page += 1
        return page
    }

    func searchForMovie(page: Int = 1, completion: @escaping (Result<[MovieSearchResult], Error>) -> Void) {
        if reachedLastPage {
            // Don't attempt to pull anymore movies if it appears we've reached the last page
            return
        }

        AF.request("https://www.omdbapi.com/?apikey=\(apiKey)&s=\(movieToSearch)&page=\(page)") { urlRequest in
            urlRequest.timeoutInterval = 3
        }
        .responseDecodable(of: MovieSearchRoot.self) { response in
            switch response.result {
            case .success(let searchResults):
                if let results = searchResults.Search {
                    if results.count < Omdb.MAX_RESULTS_PER_SEARCH {
                        self.reachedLastPage = true
                    }
                    completion(.success(results as [MovieSearchResult]))
                }
                else {
                    self.reachedLastPage = true
                    completion(.success([]))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getMovieDetails(imdbID: String, completion: @escaping (Result<MovieDetailsResult, Error>) -> Void) {
        AF.request("https://www.omdbapi.com/?apikey=\(apiKey)&i=\(imdbID)") { urlRequest in
            urlRequest.timeoutInterval = 3
        }
        .responseDecodable(of: MovieDetailsResult.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result as MovieDetailsResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
