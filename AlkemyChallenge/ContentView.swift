//
//  ContentView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 19/05/2022.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            TabView {
                ListView(filter: .alLMovies)
                    .tabItem {
                        Label("AllMovies", systemImage: "person.3")
                    }
                ListView(filter: .favorites)
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
            .background(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
