//
//  GRListView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import SwiftUI

struct GRListView: View {
    
    @StateObject var grinfo = GRInfoCrawler()
    @Binding var selected: GRNotice?
    
    var body: some View {
        List(selection: $selected){
            ForEach(grinfo.infoList){ notice in
                GRRowView(notice: notice)
                    .tag(notice)
            }
        }
    }
}
