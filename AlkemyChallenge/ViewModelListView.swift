//
//  ViewModelContentView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 14/06/2022.
//

import Foundation

extension MoviesView {
    @MainActor class ViewModelMoviesView: ObservableObject {
        @Published var allMovies = Response()
        enum FilterType {
            case alLMovies, favorites
        }

        
        func loadAllmovies() async {
        //    Creating the URL we want to read.
        //    Fetching the data for that URL.
        //    Decoding the result of that data into a struct.
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=adbba095f2045455a8907182acd1ab46&language=en-US&page=1") else {
                print("Invalid URL")
                return
            }
            do {
        //      El guion bajo en data descarta los metadatos y se queda solo con los datos de la URL
                let (data, _) = try await URLSession.shared.data(from: url)

                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    allMovies = decodedResponse
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
}
