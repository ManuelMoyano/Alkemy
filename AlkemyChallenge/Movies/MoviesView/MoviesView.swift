//
//  MoviesView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 15/06/2022.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = ViewModelMoviesView()
    @StateObject var favoriteMovies = Response()
    
    var body: some View {
        ZStack {
            TabView {
                ListView(filter: .alLMovies, filteredMovies: viewModel.allMovies, favoriteMovies: favoriteMovies)
                    .tabItem {
                        Label("AllMovies", systemImage: "person.3")
                    }
                ListView(filter: .favorites, filteredMovies: favoriteMovies, favoriteMovies: favoriteMovies)
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
            .background(.black)
        }.onAppear {
                    favoriteMovies.loadFavorites()
                    Task {
                        NetWorkingProvider.shared.loadAllMoviesAlamofire { movies in
                            viewModel.allMovies = movies
                        } failure: { error in
                            print ("Error al cargar los datos \(String(describing: error))")
                        }
                    }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
