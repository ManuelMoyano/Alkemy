//
//  AlkemyChallengeApp.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 19/05/2022.
//

import SwiftUI

@main
struct AlkemyChallengeApp: App {
    @StateObject var favoriteMovies = Response()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoriteMovies)
        }
    }
}
