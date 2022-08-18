//
//  DetailView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 20/05/2022.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel = ViewModelDetailView()
    var result: Result
    var filter: FilterType
    @State private var fav = false
    @ObservedObject var favoriteMovies: Response
    
    var body: some View {
        ZStack{
        Color.black
            .ignoresSafeArea()
        ScrollView {
            VStack {
                    HStack {
                        Text ("Añadir a Favoritos")
                            .foregroundColor(.white)
                        
                        if fav == false {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    fav.toggle()
                                    NetWorkingProvider.shared.addFavAlamofire(newFav: NewFavorite(media_type: "movie", media_id: result.id, favorite: true)) { fav in
                                        print ("Se añadio a fav")
                                        NetWorkingProvider.shared.getFavAlamorife { listFav in
                                            print("Se actualizo la lista de Fav")
                                            favoriteMovies.results = listFav.results!
                                        } failure: { error in
                                            print(error!)
                                        }

                                    } failure: { error in
                                        print("No se pudo añadir por el error \(String(describing: error))")
                                    }
                                }
                        } else {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    fav.toggle()
                                    NetWorkingProvider.shared.addFavAlamofire(newFav: NewFavorite(media_type: "movie", media_id: result.id, favorite: false)) { fav in
                                        print ("Se quito de fav")
                                        NetWorkingProvider.shared.getFavAlamorife { listFav in
                                            print("Se actualizo la lista de Fav")
                                            favoriteMovies.results = listFav.results!
                                        } failure: { error in
                                            print(error!)
                                        }
                                    } failure: { error in
                                        print("No se pudo añadir por el error \(String(describing: error))")
                                    }
                                }
                        }
                        Image(systemName: "star.fill")
                            .foregroundColor(fav ? .yellow:.gray)
                    }
                
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(result.poster_path)")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.red
                        }
                        .padding(10)
                        .frame(width: 200, height: 300, alignment: .center)
                    
                    
                    Text(result.original_title)
                        .font(.largeTitle)
                    HStack {
                    RatingView(rating: .constant(Int(result.vote_average)))
                            .font(.headline)
                        .padding(10)
                    Text (String(result.vote_average))
                        .font(.headline)
                        .foregroundColor(.white)
                    }
                    Text (result.overview)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(10)
                }
                                    
            NavigationLink {
                DetailInfoView(result: result)
            } label: {
                Text("Mas...")
                    .foregroundColor(.white)
            }
            }
        }.background(.black)
    }.onAppear {
        starfill()
//        print(result.id)
        }
        
    }
    

    func starfill () {
        for i in favoriteMovies.results {
            if i.original_title == result.original_title {
                fav = true
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(result: Result.example, filter: .alLMovies, favoriteMovies: Response())
    }
}
