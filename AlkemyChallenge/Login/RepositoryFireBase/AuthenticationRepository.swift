//
//  AuthenticationRepository.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 24/08/2022.
//

import Foundation

final class AuthenticationRepository {
    private let autthenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init (autthenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.autthenticationFirebaseDatasource = autthenticationFirebaseDatasource
    }
    func createNewUser (email: String, password: String, completionBlock: @escaping (Result<User, Error>) ->Void) {
        autthenticationFirebaseDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    func getCurrentUser ()-> User? {
        autthenticationFirebaseDatasource.getCurrentUser()
    }
    func logOut () throws {
        try autthenticationFirebaseDatasource.logOut()
    }
    func login (email: String, password: String, completionBlock: @escaping (Result<User, Error>) ->Void) {
        autthenticationFirebaseDatasource.login(email: email, password: password, completionBlock: completionBlock)
    }
    
    
    
}
