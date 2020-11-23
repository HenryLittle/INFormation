//
//  StringExtension.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/20.
//

import Foundation

extension String {
    func matchingStrings(regex: String) -> [NSTextCheckingResult] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.allowCommentsAndWhitespace]) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results
    }
}
