//
//  AlkemyChallengeApp.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 19/05/2022.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AlkemyChallengeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if (authenticationViewModel.user != nil) {
                MoviesView()
                    .environmentObject(authenticationViewModel)
            } else {
                LoginView()
                    .environmentObject(authenticationViewModel)
            }
        }
    }
}
