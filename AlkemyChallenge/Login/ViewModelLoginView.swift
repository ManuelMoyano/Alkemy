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
        private let apiKey = "adbba095f2045455a8907182acd1ab46"
        private let kStatusOk = 200...499
        
        @Published var tokenRequest = TokenRequest()
        @Published var stringError = ""
        
        @Published var sessionId = SessionIdRequest()
        
        func getTokenAlamofire (){
            
            let url = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
            
            AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: TokenRequest.self) {  response in
                
                if let token = response.value {
                    self.tokenRequest = token
                    print("Se genero el TOKEN")
                    print("El Token es: \(token.request_token)")
                } else {
//                    self.stringError = response.error?.localizedDescription ?? ""
                    print("No se genero el Token por el error \(String(describing: response.error))")
                }
            }
        }
        
        
        func creatSessionID() {
            let url = "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)"
            let tokenPost: TokenPost = TokenPost(request_token: tokenRequest.request_token )
            
            AF.request(url, method: .post, parameters: tokenPost, encoder: JSONParameterEncoder.default).validate(statusCode: kStatusOk).responseDecodable (of: SessionIdRequest.self) {  response in
                
                if let sessionId = response.value {
                    self.sessionId = sessionId
                    print("La Session id es: \(String(describing: sessionId.session_id))")
                } else {
                    print(response.error ?? "No error description founded")
                    print("No se consiguio la Session")
                }
            }
        }
        
        
    }
}
