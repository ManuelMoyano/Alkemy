//
//  LoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 02/06/2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var login: LogInCheck
    @StateObject var viewModel = ViewModelLoginView()
    @State private var email = "example@gmail.com"
    @State private var password = "1234"
    @State private var showingAlert = false
    @State private var showingSheet = false
    private let validEmails = ["@gmail.com","@hotmail.com"]
    var hasValidEmail: Bool {
        if email.isEmpty {
            return false
        }
        if validEmails.contains(where: email.contains){
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

                    TextField("\(email)", text: $email)
                        .border(Color(UIColor.separator))
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    
                    Text ("Enter your password:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    SecureField("\(password)", text: $password)
                        .border(Color(UIColor.separator))
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                                    print(error ?? "No error description")
                                    viewModel.stringError = error.debugDescription
                                }
                                showingSheet.toggle()
                            } else {
                                showingAlert = true
                            }
                        }.sheet(isPresented: $showingSheet) {
                            TokenAuthenticationView(token: viewModel.tokenRequest, url: "https://www.themoviedb.org/authenticate/\(viewModel.tokenRequest.request_token)")
                        }
                        } else {
                            if hasValidEmail {
                                Button ("Login") {
                                    login.login.toggle()
                                }
                                    .foregroundColor(.white)
                                    .frame(width:120, height: 30)
                                    .background(.blue)
                                    .cornerRadius(_:20)
                            }
                        }
                    }
                    .alert("Invalid email adress", isPresented: $showingAlert) {
                        Button("OK") { }
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
