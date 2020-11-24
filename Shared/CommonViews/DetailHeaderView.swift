//
//  DetailHeaderView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import SwiftUI

struct DetailHeaderView: View {
    @Environment(\.openURL) var openURL
    let title: String
    let urlencoded: String
    var format: String? = nil
    
    var body: some View {
        HStack{
            Text(title)
            if format != nil {
                FmtTagView(text: format!)
            }
            Button("Open in Safari") {
                openURL(URL(string: urlencoded)!)
            }
        }
    }
}
