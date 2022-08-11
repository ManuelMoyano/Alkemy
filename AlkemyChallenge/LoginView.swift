//
//  LoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 02/06/2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var login: LogInCheck
    @State private var email = "example@gmail.com"
    @State private var password = "1234"
    @State private var showingAlert = false
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
                        NavigationLink {
                            MoviesView()
                        } label: {
                            Text("Login")
                            .foregroundColor(.white)
                            .frame(width:100, height: 30)
                            .background(.gray)
                            .cornerRadius(_:20)
                        }.onTapGesture {
                            if hasValidEmail {
                            login.login.toggle()
                            print (login.login)
                            } else {
                                showingAlert = true
                            }
                        }
                    }
//                    .disabled(hasValidEmail == false)
                    .alert("Invalid email adress", isPresented: $showingAlert) {
                        Button("OK") { }
                    }
                }
                .frame(width: 280, height: 350, alignment: .center)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 30))

            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
