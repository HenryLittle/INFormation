//
//  GradInfoCrawler.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/23.
//

import Foundation
import SwiftUI
import Combine

class GRInfoCrawler: ObservableObject {
    @Published var infoList: [GRNotice] = []
    
    let grsurlstr = "http://grs.zju.edu.cn/redir.php?catalog_id=16313"
    let grsregex = "catalog_id=(?<catalogId>[0-9]+)&object_id=(?<objectId>[0-9]+).*?title=\"(?<noticeTitle>.*?)\".*?e\">(?<noticeDate>[0-9\\-]*?)<"
    let grregexComponents = ["catalogId", "objectId", "noticeTitle", "noticeDate"]
    
    init(){
        fetch()
    }
    
    func fetch() {
        guard let url = URL(string: grsurlstr) else {
            fatalError("Failed to form proper URL")
        }

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                fatalError("Decode failed")
            }
            // grs uses UTF-8, this decoding method allows unkown bytes (safer)
            let document = String(decoding: data, as: UTF8.self)
            // publish the result and use in SwiftUI
            let matches = document.matchingStrings(regex: self.grsregex, options: [.allowCommentsAndWhitespace, .dotMatchesLineSeparators])
            matches.forEach{ match in
                let notice = GRNotice(catalogId: document.getComponent(from: match, withName: self.grregexComponents[0]),
                                     objectId: document.getComponent(from: match, withName: self.grregexComponents[1]),
                                     title: document.getComponent(from: match, withName: self.grregexComponents[2]),
                                     date: document.getComponent(from: match, withName: self.grregexComponents[3]))
                DispatchQueue.main.async {
                    self.infoList.append(notice)
                }
            }
        }
        task.resume()
    }
    
    static func getComponent(from match: NSTextCheckingResult, withName name: String, in document: String) -> String {
        let mrange = match.range(withName: name)
        if mrange.location != NSNotFound, let range = Range(mrange, in: document) {
            return String(document[range])
        } else {
            return "Match not found!"
        }
    }
}

struct GRNotice: Identifiable, Hashable {
    var id = UUID()
    var catalogId: String = "16313"
    var objectId: String = ""
    var title: String = "No title"
    var date: String = "- - -"
}
