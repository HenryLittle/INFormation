//
//  GRDetailView.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import SwiftUI

struct GRDetailView: View {
    
    var selected: GRNotice
    let baseurl: String = "http://grs.zju.edu.cn/redir.php?catalog_id=%s&object_id=%s"
    
    var url: String {
        get {
            return "http://grs.zju.edu.cn/redir.php?catalog_id=\(selected.catalogId)&object_id=\(selected.objectId)"
        }
    }
    
    var body: some View {
        DetailHeaderView(title: selected.title, urlencoded: url)
        WebView(url: url, source: .grs)
    }
}

