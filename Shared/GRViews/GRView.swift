//
//  GRView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import SwiftUI

struct GRView: View {
    
    @State var selected: GRNotice?
    
    var body: some View {
        NavigationView{
            GRListView(selected: $selected)
                .frame(width: 300)
            if selected != nil {
                GRDetailView(selected: selected!)
                    .frame(width: 800)
            }
        }
    }
}
