//
//  UserDefaults.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 23/08/2022.
//

import Foundation

final class UserDefaultsFunctions {
    
    var sessionId = try? JSONDecoder().decode(SessionIdRequest.self, from: UserDefaults.standard.object(forKey: "SavedData") as? Data ?? Data())
    
    static let shared = UserDefaultsFunctions()
    
    private init() {}
    
    func saveToUserDefault (data: SessionIdRequest){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
            print("SessionId Guardada en UserDefaults")
        }
    }
    
    func loadFromUserDedault () {
        if let savedData = UserDefaults.standard.object(forKey: "SavedData") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(SessionIdRequest.self, from: savedData) {
                 sessionId = loadedData
            }
        }
    }
}
