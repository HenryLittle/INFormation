//
//  StringExtension.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import Foundation

extension String {
    
    func matchingStrings(regex: String, options: NSRegularExpression.Options = [.allowCommentsAndWhitespace]) -> [NSTextCheckingResult] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: options) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results
    }
    
    func getComponent(from match: NSTextCheckingResult, withName name: String) -> String {
        let mrange = match.range(withName: name)
        if mrange.location != NSNotFound, let range = Range(mrange, in: self) {
            return String(self[range])
        } else {
            return "Match not found!"
        }
    }
}
