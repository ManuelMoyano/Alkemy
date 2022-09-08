//
//  LoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 02/06/2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = ViewModelLoginView()
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var userEmail = ""
    @State private var userPassword = ""
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

                    
                    TextField("example@gmail.com", text: $userEmail)
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
                    
                    SecureField("********", text: $userPassword)
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
                                Button ("Login") {
                                    if hasValidEmail {
                                        authenticationViewModel.login(email: userEmail, password: userPassword) { (error) in
                                            showingError.toggle()
                                        }
                                    } else {
                                        showingAlertInvalidAdress = true
                                    }
                                }
                                    .foregroundColor(.white)
                                    .frame(width:120, height: 30)
                                    .background(.blue)
                                    .cornerRadius(_:20)
                            
                        }
                    }
                    .alert("Invalid email adress", isPresented: $showingAlertInvalidAdress) {
                        Button("OK", role: .cancel) { }
                    }
                    .alert("Error login user The password is invalid or the user does not have a password", isPresented: $showingError) {
                        Button("OK", role: .cancel) {
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
        LoginView()
    }
}
