//
//  AuthenticationViewModel.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 24/08/2022.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    private let authentificationRepository: AuthenticationRepository
    
    init (authentificationRepository: AuthenticationRepository = AuthenticationRepository()){
        self.authentificationRepository = authentificationRepository
        getCurrentUser()
    }
    
    func creatNewUser (email: String, password: String){
        authentificationRepository.createNewUser(email: email, password: password) {[weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    func getCurrentUser () {
        self.user = authentificationRepository.getCurrentUser()
    }
    func logOut() {
        do {
        try authentificationRepository.logOut()
            self.user = nil
            print ("Se aplico el LogOut")
        } catch {
            print ("Error logout")
        }
    }
    func login(email: String, password: String, failure: @escaping (_ error: Error?) -> ()){
        authentificationRepository.login(email: email, password: password) {[weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.messageError = nil
            case .failure(let error):
                failure(error)
                self?.messageError = error.localizedDescription
            }
        }
    }
}


