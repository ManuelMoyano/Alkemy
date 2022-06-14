//
//  DetailInfoView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 25/05/2022.
//

import SwiftUI

struct DetailInfoView: View {
    
    var result: Result
    @State private var genres = [Genre]()
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
        
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(result.backdrop_path)")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.red
                    }
                    .padding(5)
                    .frame(width: 380, height: 300, alignment: .center)
                    .scaledToFit()
                VStack {
                        Text ("Genero:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(0.0)
                        VStack {
                            ForEach (result.genre_ids, id: \.self) { genre in
                                ForEach (genres, id: \.self) { item in
                                    if genre == item.id {
                                        Text (item.name)
                                            .padding(.bottom, 2.0)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                    Text ("Idioma Original:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    Text (result.original_language)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.bottom, 2.0)
                    Text ("Fecha de Estreno:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    Text (result.release_date)
                    .font(.body)
                    .padding(.bottom, 1.0)
                    Spacer()
                .task {
                        await loadgenres()
                }.padding(10)
            }
    }
    }
    
    func loadgenres() async {
        guard let url = URL (string: "https://api.themoviedb.org/3/genre/movie/list?api_key=adbba095f2045455a8907182acd1ab46&language=en-US" ) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Genres.self, from: data) {
                 genres = decodedResponse.genres
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct DetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfoView(result: Result.example)
    }
}
