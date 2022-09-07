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

            
    }
    
}
