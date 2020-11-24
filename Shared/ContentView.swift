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
        NavigationView{
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
                            .animation(.easeInOut)
                    }
                }
                .frame(width: 200)
                .padding(.top, 16)
                
            }
            selectedSource.contentView
        }.frame(minHeight: 800)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
