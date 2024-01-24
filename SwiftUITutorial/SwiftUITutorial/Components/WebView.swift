//
//  WebView.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }

    func makeUIView(context: Context) -> UIView {
        let wkWebView = WKWebView()
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            wkWebView.load(request)
        }
        return wkWebView
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}
