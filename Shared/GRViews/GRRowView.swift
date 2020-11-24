//
//  GRRowView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import SwiftUI

struct GRRowView: View {
    var notice: GRNotice = GRNotice()
    
    var body: some View {
        VStack(alignment: .leading){
            Text(notice.title)
                .fontWeight(.bold)
                .lineLimit(3)
                .truncationMode(.tail)
            Spacer()
                .frame(height: 4)
            HStack{
                Spacer()
                Text(notice.date)
                    .font(.caption)
            }
        }
        .padding([.all], 4)
    }
}

struct GRRowView_Previews: PreviewProvider {
    static var previews: some View {
        GRRowView()
    }
}
