//
//  Response.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 19/05/2022.
//

import Foundation


class Response: Codable, ObservableObject {
    @Published var results = [Result]()
    
    static let example = Response()
    
    //    Manually conforming to Codable
        enum CodingKeys: CodingKey {
            case results
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            results = try container.decode([Result].self, forKey: .results)
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(results, forKey: .results
        )
        }
    init() {}
    
    //    Carga de datos en UserDefaults
    let saveKey = "SavedData"

    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Result].self, from: data) {
                results = decoded
                return
            }
        }

        results = [Result]()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}


struct Result: Codable, Equatable {
    var poster_path: String
//    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
//    var title: String
    var backdrop_path: String
    var popularity: Double
//    var vote_count: Int
//    var video: Bool
    var vote_average: Double
    
    static let example = Result(poster_path:"Imagen", overview: "Descripcion", release_date: "Enero-2022", genre_ids: [2,5,1,9,10,12,19], id: 1, original_title: "SuperMan", original_language: "English", backdrop_path: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg", popularity: 8.1, vote_average: 4.5)
    
}

struct Genres: Codable {
    var genres: [Genre]
}
struct Genre: Codable, Hashable {
    var id: Int
    var name: String
}

enum FilterType {
    case alLMovies, favorites
}

