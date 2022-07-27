//
//  ContentView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 19/05/2022.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView{
            VStack {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
