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
    var source: WebSource = .common
    
    func makeWebView() -> WKWebView {
        WKWebView()
    }
    
    func updateWebView(wkWebView: WKWebView) {
        guard let url = URL(string: self.url) else {
            print("illegal url")
            return
        }
        let request = URLRequest(url: url)
        wkWebView.load(request)
        wkWebView.configuration.userContentController.addUserScript(WKUserScript(source: source.jsScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false))
    }
}

enum WebSource {
    case grs
    case ugs
    case common
    
    var jsScript: String {
        switch self{
        case .grs: return "document.body.innerHTML = document.getElementsByClassName('con-xxgg-right')[0].innerHTML;"
//        case .grs: return "document.getElementsByClassName('cg-content-left')[0].remove()"
        default:   return ""
        }
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
