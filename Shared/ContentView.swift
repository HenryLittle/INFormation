//
//  ContentView.swift
//  Shared
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var jwbinfo = UGInfoCrawler()
    @State var selected: UGNotice?
    @State var noticeType: UGNoticeType = .collage
    
    var urlencoded: String {
        get {
            selected?.link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "http://jwbinfosys.zju.edu.cn"
        }
    }
    // view for ug information, extract it later
    var body: some View {
        NavigationView{
            VStack{
                Picker(selection: $noticeType, label: Text("Notice Type")){
                    ForEach(UGNoticeType.allCases, id:\.self) { value in
                        Text(value.name.capitalized)
                            .tag(value)

                    }
                }
                .onChange(of: noticeType) { newType in
                    self.jwbinfo.fetch(type: newType.rawValue)
                }
                .pickerStyle(SegmentedPickerStyle())
                .labelsHidden()
                .padding(.horizontal, 16)
                List(selection: $selected){
                    ForEach(jwbinfo.infoList){ notice in
                        RowView(notice: notice)
                            .tag(notice)
                    }
                }
            }
            VStack{
                if selected != nil {
                    HStack{
                        Text(selected!.title)
                        FmtTagView(text: selected!.format)
                        Button("Open in Safari") {
                            openURL(URL(string: urlencoded)!)
                        }
                        
                    }
                    WebView(url: selected!.link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "http://jwbinfosys.zju.edu.cn")
                }
            }
        }.frame(idealWidth: 700, idealHeight: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
