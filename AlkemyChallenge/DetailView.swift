//
//  DetailView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 20/05/2022.
//

import SwiftUI

struct DetailView: View {
    var result: Result
    var filter: FilterType
    @State private var fav = false
    @ObservedObject var movies: Response
    
    var body: some View {
        ZStack{
        Color.black
            .ignoresSafeArea()
        ScrollView {
            VStack {
                if filter == .alLMovies {
                    HStack {
                        Text ("Añadir a Favoritos")
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .onTapGesture {
                                fav.toggle()
                                loadFav()
                            }
                        Image(systemName: "star.fill")
                            .foregroundColor(fav ? .yellow:.gray)
                    }
                } else {
                    HStack {
                        Text ("Añadir a Favoritos")
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
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
    }
    }
    
    func loadFav (){
        movies.results.append(result)
        print(movies.results.count)
        movies.save()
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(result: Result.example, filter: .alLMovies, movies: Response())
    }
}
