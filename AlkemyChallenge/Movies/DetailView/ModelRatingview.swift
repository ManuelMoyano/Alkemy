//
//  ModelRatingview.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 18/08/2022.
//

import Foundation

struct RateResponse: Decodable {
//    MODELO DE RESPUESTA
//      "status_code": 1,
//      "status_message": "Success."
    var status_code: Int?
    var status_message: String?
}

struct NewRate: Encodable {
    var value: Float
}
