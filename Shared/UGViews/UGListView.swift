//
//  UGListView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/23.
//

import SwiftUI

struct UGListView: View {
    
    @State var noticeType: UGNoticeType = .collage
    @Binding var selected: UGNotice?
    // introduced in swiftUI 2, be aware of its difference with @ObservedObject
    // https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9
    @StateObject var jwbinfo = UGInfoCrawler()
    
    var body: some View {
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
                    UGRowView(notice: notice)
                        .tag(notice)
                }
            }
        }
    }
}

struct UGListView_Previews: PreviewProvider {
    static var previews: some View {
        UGListView(selected: .constant(nil))
    }
}
