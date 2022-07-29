//
//  AlkemyChallengeApp.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 19/05/2022.
//

import SwiftUI

@main
struct AlkemyChallengeApp: App {
//    @StateObject var favoriteMovies = Response()
    @StateObject var login: LogInCheck = LogInCheck()
    
    var body: some Scene {
        WindowGroup {
            if login.login {
                MoviesView()
                    .environmentObject(login)
            
            } else {
                LoginView()
                    .environmentObject(login)
            }
        }
    }
}
