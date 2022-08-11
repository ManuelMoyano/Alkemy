//
//  ViewModelContentView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 14/06/2022.
//

import Foundation
import Alamofire

extension MoviesView {
    @MainActor class ViewModelMoviesView: ObservableObject {
        @Published var allMovies = Response()
        private let kStatusOk = 200...299
        private let apiKey = "adbba095f2045455a8907182acd1ab46"
        private let kBaseUrl = "https://api.themoviedb.org/3/movie/popular?"
        private let kBaseSearch = "&language=en-US&page=1"

        
        func loadAllMoviesAlamofire (success: @escaping (_ movies: Response) -> (), failure: @escaping (_ error: Error?) -> ()){
            
            let url = "\(kBaseUrl)api_key=\(apiKey)\(kBaseSearch)"
            
            AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: Response.self) {  response in
                
                if let movies = response.value {
                    success(movies)
                } else {
                    failure(response.error)
                }
            }
        }
        
        
    }
    
}
