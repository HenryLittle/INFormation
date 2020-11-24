//
//  ContentView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedSource: SourceMenu = .undergraduate
    
    var body: some View {
        HStack(alignment: .center){
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 24){
                    ForEach(SourceMenu.allCases){ source in
                        Text(source.title)
                            .foregroundColor(selectedSource == source ? Color(NSColor.systemBlue) : Color(NSColor.textColor))
                            .font(.title)
                            .bold()
                            .onTapGesture{
                                self.selectedSource = source
                            }
                    }
                }
                .frame(width: 200)
                .padding(.top, 16)
                
            }.listStyle(SidebarListStyle())
            selectedSource.contentView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
