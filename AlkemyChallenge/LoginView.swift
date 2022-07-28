//
//  LoginView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 02/06/2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = "example@gmail.com"
    @State private var password = "1234"
    
    
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

                    TextField("\(email)", text: $email)
                        .border(Color(UIColor.separator))
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    
                    Text ("Enter your password:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    TextField("\(password)", text: $password)
                        .border(Color(UIColor.separator))
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        NavigationLink {
                            MoviesView()
                        } label: {
                            Text("Login")
                            .foregroundColor(.white)
                            .frame(width:100, height: 30)
                            .background(.gray)
                            .cornerRadius(_:20)
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
