//
//  RowView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import SwiftUI

struct RowView: View {
    @State var notice: UGNotice = UGNotice()
    
    var body: some View {
        VStack(alignment: .leading){
            Text(notice.title)
                .fontWeight(.bold)
                .lineLimit(3)
                .truncationMode(.tail)
            HStack{
                Text(notice.source)
                    .font(.caption)
                Spacer()
                Text(notice.date)
                    .font(.caption)
            }
        }
        .padding([.all], 4)
        
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
