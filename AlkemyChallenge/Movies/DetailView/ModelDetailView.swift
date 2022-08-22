//
//  Favorites.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 16/08/2022.
//

import Foundation

struct NewFavorite: Codable {
//    MODELO DE BODY REQUEST
//    "media_type": "movie",
//    "media_id": 550,
//    "favorite": true
    let media_type: String
    let media_id: Int
    let favorite: Bool
}

struct NewFavoriteResponse: Decodable {
//    MODELO DE RESPUESTA
//      "status_code": 12,
//      "status_message": "The item/record was updated successfully."
    var status_code: Int?
    var status_message: String?
}

struct ListFavorites: Decodable {
//    MODELO DE BODY REQUEST
//    {
//      "page": 1,
//      "results": [
//        {
//          "adult": false,
//          "backdrop_path": null,
//          "genre_ids": [
//            16
//          ],
//          "id": 9806,
//          "original_language": "en",
//          "original_title": "The Incredibles",
//          "overview": "Bob Parr has given up his superhero days to log in time as an insurance adjuster and raise his three children with his formerly heroic wife in suburbia. But when he receives a mysterious assignment, it's time to get back into costume.",
//          "release_date": "2004-11-04",
//          "poster_path": null,
//          "popularity": 0.167525,
//          "title": "The Incredibles",
//          "video": false,
//          "vote_average": 6.8,
//          "vote_count": 1584
//        }
//      ],
//      "total_pages": 4,
//      "total_results": 77
//    }
    
    var page: Int?
    var results: [Result]?
    var total_pages: Int?
    var total_results: Int?
}

