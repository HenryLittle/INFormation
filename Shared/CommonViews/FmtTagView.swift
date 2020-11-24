//
//  FmtTagView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI

struct FmtTagView: View {
    var text: String
    var body: some View {
        Text(text)
            .textCase(.uppercase)
            .padding([Edge.Set.vertical], 2)
            .padding([Edge.Set.horizontal], 4)
            .background(Color.pink)
            .cornerRadius(4)
    }
}

struct FmtTagView_Previews: PreviewProvider {
    static var previews: some View {
        FmtTagView(text: "tag")
    }
}
