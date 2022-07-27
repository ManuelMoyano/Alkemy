//
//  ListView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 25/05/2022.
//

import SwiftUI

struct ListView: View {
    var filter: FilterType
    var viewTitle: String {
        switch filter {
        case .alLMovies:
            return "Popular Movies"
        case .favorites:
            return "Favorites Movies"
        }
    }
    var filteredMovies: Response
    @ObservedObject var favoriteMovies: Response
    
    

    var body: some View {
        NavigationView {
            List (filteredMovies.results, id: \.id) { item in
                VStack (alignment: .leading) {
                    NavigationLink {
                        DetailView (result: item, movies: favoriteMovies)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path)")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Text (item.original_title)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .foregroundColor(.white)
                .listRowBackground(Color.black)
            }
            .navigationTitle(viewTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .listStyle(.grouped)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(filter: FilterType.alLMovies, filteredMovies: Response(), favoriteMovies: Response())
    }
}

