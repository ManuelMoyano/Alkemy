//
//  WebView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 12/08/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let defaultUrl = "https://www.google.com.ar/"
    let url: String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.load(URLRequest(url: (URL(string: url) ?? URL(string: defaultUrl))!))
    }


}
