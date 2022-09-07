//
//  LoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 02/06/2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = ViewModelLoginView()
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var userEmail = "example@gmail.com"
    @State private var userPassword = "1234"
    @State private var showingAlertInvalidAdress = false
    @State private var showingSheet = false
    @State private var showingError = false
    private let validEmails = ["@gmail.com","@hotmail.com"]
    var hasValidEmail: Bool {
        if userEmail.isEmpty {
            return false
        }
        if validEmails.contains(where: userEmail.contains){
            return true
        }
        return false
    }
    
    
    var body: some View {
            ZStack{
                Image("BackImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 8)
                VStack {
                    Text ("Enter your email adress:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .keyboardType(.emailAddress)

                    
                    TextField("\(userEmail)", text: $userEmail)
                        .autocapitalization(.none)
                        .textFieldStyle(.roundedBorder)
                        .border(Color(UIColor.separator))
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    
                    Text ("Enter your password:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    SecureField("\(userPassword)", text: $userPassword)
                        .textFieldStyle(.roundedBorder)
                        .border(Color(UIColor.separator))
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    Section{
                        if UserDefaultsFunctions.shared.sessionId?.session_id == "" {
                            Text("Sign up")
                            .foregroundColor(.white)
                            .frame(width:160, height: 30)
                            .background(.gray)
                            .cornerRadius(_:20)
                            .onTapGesture {
                            if hasValidEmail {
                                NetWorkingProvider.shared.getTokenAlamofire { token in
                                    viewModel.tokenRequest = token
                                } failure: { error in
                                    viewModel.stringError = error.debugDescription
                                    showingError.toggle()
                                }
                                authenticationViewModel.creatNewUser(email: userEmail, password: userPassword)
                                showingSheet.toggle()
                            } else {
                                showingAlertInvalidAdress = true
                            }
                        }.sheet(isPresented: $showingSheet) {
                            TokenAuthenticationView(token: viewModel.tokenRequest, url: "https://www.themoviedb.org/authenticate/\(viewModel.tokenRequest.request_token)")
                        }
                        } else {
                            if hasValidEmail {
                                Button ("Login") {
                                    authenticationViewModel.login(email: userEmail, password: userPassword)
                                    if authenticationViewModel.messageError != nil {
                                        showingError.toggle()
                                    }
                                }
                                    .foregroundColor(.white)
                                    .frame(width:120, height: 30)
                                    .background(.blue)
                                    .cornerRadius(_:20)
                            }
                        }
                    }
                    .alert("Invalid email adress", isPresented: $showingAlertInvalidAdress) {
                        Button("OK") { }
                    }
                    .alert("LogIn Error", isPresented: $showingError) {
                        Button("OK") {
                        }
                    }
                }
                .frame(width: 280, height: 350, alignment: .center)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }.onAppear {
                UserDefaultsFunctions.shared.loadFromUserDedault()
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authenticationViewModel: AuthenticationViewModel())
    }
}
