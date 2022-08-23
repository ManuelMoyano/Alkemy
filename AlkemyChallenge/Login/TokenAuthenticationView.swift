//
//  TokenAuthenticationView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 12/08/2022.
//

import SwiftUI
import WebKit

struct TokenAuthenticationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModelTokenAuthenticationView()
    var token: TokenRequest
    let url: String
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Please Confirm Token and Exit ->")
                Spacer()
                Button{
                    NetWorkingProvider.shared.creatSessionID(token: token) { sessionId in
                        UserDefaultsFunctions.shared.saveToUserDefault(data: sessionId)
                    } failure: { error in
                        print(error ?? "No error description")
                    }
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        
                }
            }
            WebView(url: url)
        }
    }
}

struct TokenAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        TokenAuthenticationView(token: TokenRequest(), url: "")
    }
}
