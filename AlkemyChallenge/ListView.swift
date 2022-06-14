//
//  ListView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 25/05/2022.
//

import SwiftUI

struct ListView: View {
    @State private var results = Response()
    @StateObject var favoritesMovies = Response()
    enum filterType {
        case alLMovies, favorites
    }
    @State var filter: filterType
    var viewTitle: String {
        switch filter {
        case .alLMovies:
            return "Popular Movies"
        case .favorites:
            return "Favorites Movies"
        }
    }
    var filteredMovies: Response {
        switch filter {
        case .alLMovies:
            return results
            
        case .favorites:
            return favoritesMovies
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            List (filteredMovies.results, id: \.id) { item in
                VStack (alignment: .leading) {
                    NavigationLink {
                        DetailView (result: item, favoritesMovies: favoritesMovies)
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
            .task {
                await loadData()
            }
            .navigationTitle(viewTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .listStyle(.grouped)

    }
    
    
    func loadData() async {
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
                results = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(filter: .alLMovies)
    }
}
