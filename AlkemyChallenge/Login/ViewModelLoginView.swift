//
//  ViewModelLoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 12/08/2022.
//

import Foundation
import Alamofire
import SwiftUI

extension LoginView {
    @MainActor class ViewModelLoginView: ObservableObject {
                
        @Published var tokenRequest = TokenRequest()
        @Published var stringError = ""
        @Published var sessionId = SessionIdRequest()
        @Published var newFav = NewFavorite(media_type: "movie", media_id: 507086, favorite: true)
        @Published var newFavResponse = NewFavoriteResponse()
    
//        ID EJEMPLOS
//        minions 438148
//        Lightyear 718789
//        Jurasic 507086
//        Thor 616037
//        X 760104
        
    }
}
