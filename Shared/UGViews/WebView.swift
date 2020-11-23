//
//  WebView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI
import WebKit

struct WebView {
    var url: String
    
    func makeWebView() -> WKWebView {
        guard let url = URL(string: self.url) else {
            print("illegal url")
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }
    
    func updateWebView(wkWebView: WKWebView) {
        guard let url = URL(string: self.url) else {
            print("illegal url")
            return
        }
        print(self.url)
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
}

#if os(macOS)
extension WebView: NSViewRepresentable{
    func makeNSView(context: Context) -> WKWebView {
        makeWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        updateWebView(wkWebView: nsView)
    }
}
#else
extension WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        makeWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
#endif
