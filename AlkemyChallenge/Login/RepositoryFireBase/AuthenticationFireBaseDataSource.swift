//
//  AuthenticationFireBaseDataSource.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 24/08/2022.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

class AuthenticationFirebaseDatasource {

    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) ->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print ("New user created with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
        
    }
    func getCurrentUser ()-> User?{
        guard let email = Auth.auth().currentUser?.email else{
            return nil
        }
        return .init(email: email)
    }
    func logOut () throws {
        try Auth.auth().signOut()
    }
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) ->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { AuthDataResult, error in
            if let error = error {
                print("Error login user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print ("User login with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
        
    }
}
