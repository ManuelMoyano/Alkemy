//
//  ModelDetailInfoView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 18/08/2022.
//

import Foundation

struct Genres: Codable {
    var genres: [Genre]
}
struct Genre: Codable, Hashable {
    var id: Int
    var name: String
}
