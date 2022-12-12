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
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func searchForMovie(title: String, completion: @escaping (Result<[MovieSearchResult], Error>) -> Void) {
        AF.request("https://www.omdbapi.com/?apikey=\(apiKey)&s=\(title)") { urlRequest in
            urlRequest.timeoutInterval = 3
        }
        .responseDecodable(of: MovieSearchRoot.self) { response in
            switch response.result {
            case .success(let searchResults):
                if let results = searchResults.Search {
                    completion(.success(results as [MovieSearchResult]))
                }
                else {
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
