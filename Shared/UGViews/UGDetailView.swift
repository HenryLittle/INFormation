//
//  DetailView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI

struct UGDetailView: View {
    
    @Environment(\.openURL) var openURL
    var selected: UGNotice
    
    var urlencoded: String {
        get {
            selected.link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "http://jwbinfosys.zju.edu.cn"
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(selected.title)
                FmtTagView(text: selected.format)
                Button("Open in Safari") {
                    openURL(URL(string: urlencoded)!)
                }
                
            }
            if ["docx", "doc"].contains(selected.format) {
                Text("Unsupported preview content type, please view in Safari")
                    .foregroundColor(.gray)
            } else {
                WebView(url: selected.link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "http://jwbinfosys.zju.edu.cn")
            }
        }
    }
}
