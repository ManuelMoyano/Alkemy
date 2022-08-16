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
    let url: String
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Please Confirm Token and Exit ->")
                Spacer()
                Button{
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
        TokenAuthenticationView(url: "")
    }
}
