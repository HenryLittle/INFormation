//
//  ContentView.swift
//  Shared
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI

struct UGView: View {
    
    @State var selected: UGNotice?
    
    
    // view for ug information, extract it later
    var body: some View {
        NavigationView{
            UGListView(selected: $selected)
                .frame(width: 300)
            if selected != nil {
                UGDetailView(selected: selected!)
            }
        }
    }
}


struct UGView_Previews: PreviewProvider {
    static var previews: some View {
        UGView()
    }
}
