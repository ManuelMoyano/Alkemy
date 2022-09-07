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
                ListView(authenticationViewModel: AuthenticationViewModel(), filter: .alLMovies, filteredMovies: viewModel.allMovies, favoriteMovies: favoriteMovies)
                    .tabItem {
                        Label("AllMovies", systemImage: "person.3")
                    }
                ListView(authenticationViewModel: AuthenticationViewModel(), filter: .favorites, filteredMovies: favoriteMovies, favoriteMovies: favoriteMovies)
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
//            .background(.black)
        }.onAppear {
            NetWorkingProvider.shared.getFavAlamorife { listFav in
                favoriteMovies.results = listFav.results!
            } failure: { error in
                print(error!)
            }
            NetWorkingProvider.shared.loadAllMoviesAlamofire { movies in
                viewModel.allMovies = movies
            } failure: { error in
                print ("Error al cargar los datos \(String(describing: error))")
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
