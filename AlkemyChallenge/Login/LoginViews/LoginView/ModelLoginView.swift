//
//  ModelLoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 12/08/2022.
//

import Foundation

class TokenRequest: Decodable, ObservableObject {
//    MODELO DE RESPUESTA
//    "success": true,
//    "expires_at": "2016-08-26 17:04:39 UTC",
//    "request_token": "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd"
    
    var success: Bool?
    var expires_at: String?
    var request_token = ""
}

class SessionIdRequest: Codable, ObservableObject {
//    MODELO DE RESPUESTA
//    "success": true,
//    "session_id": "79191836ddaa0da3df76a5ffef6f07ad6ab0c641"
    
    var success: Bool?
    var session_id = ""
}

struct TokenPost: Encodable {
    let request_token: String
}


