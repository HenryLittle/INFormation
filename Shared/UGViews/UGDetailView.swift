//
//  DetailView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI

struct UGDetailView: View {
    
    var selected: UGNotice
    
    var urlencoded: String {
        get {
            selected.link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "http://jwbinfosys.zju.edu.cn"
        }
    }
    
    var body: some View {
        VStack{
            DetailHeaderView(
                title: selected.title,
                urlencoded: urlencoded,
                format: selected.format
            )
            if ["docx", "doc"].contains(selected.format) {
//                Text("Unsupported preview content type, please view in Safari")
//                    .foregroundColor(.gray)
                MyPreview(url: urlencoded, name: "\(selected.title).\(selected.format)")
            } else {
                WebView(url: urlencoded)
            }
        }
    }
}
