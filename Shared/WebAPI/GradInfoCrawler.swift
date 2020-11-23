//
//  GradInfoCrawler.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/23.
//

import Foundation
import SwiftUI
import Combine

class GDInfoCrawler: ObservableObject {
    @Published var infoList: [UGNotice] = []
    
    let jwburlstr = "http://jwbinfosys.zju.edu.cn/jwggcx.aspx?type=%d"
    let jwbregex = "\\('(?<linkAddress>https*:\\/\\/.*?)','.*?0\\/>\\ *(?<noticeTitle>.*?)<\\/a>.*?<td>(?<noticeSource>.*?)<\\/td>.*?<td>(?<noticeDate>.*?)<\\/td>"
    let jwbregexComponents = ["linkAddress", "noticeTitle", "noticeSource", "noticeDate"]
    
    init(){
        fetch(type: 1)
    }
    
    func fetch(type: Int) {
        let actualurlstr = String(format: jwburlstr, type)
        guard let url = URL(string: actualurlstr) else {
            fatalError("Failed to form proper URL")
        }

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                fatalError("Decode failed")
            }
            // jwbinfo uses GB2312 encoding
            let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
            let document = NSString(data: data, encoding: encoding)! as String
            // publish the result and use in SwiftUI
            let matches = document.matchingStrings(regex: self.jwbregex)
            matches.forEach{ match in
                let notice = UGNotice(link: UGInfoCrawler.getComponent(from: match, withName: self.jwbregexComponents[0], in: document),
                                      title: UGInfoCrawler.getComponent(from: match, withName: self.jwbregexComponents[1], in: document),
                                      source: UGInfoCrawler.getComponent(from: match, withName: self.jwbregexComponents[2], in: document),
                                      date: UGInfoCrawler.getComponent(from: match, withName: self.jwbregexComponents[3], in: document))
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
