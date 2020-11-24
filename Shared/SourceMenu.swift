//
//  SourceMenu.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import Foundation
import SwiftUI

enum SourceMenu: Int, CaseIterable, Identifiable {
    // make it identifiable
    var id: Int {
        return self.rawValue
    }
    
    case undergraduate, graduate
    
    var title: String {
        get {
            switch self {
            case .undergraduate: return "Under Graduate"
            case .graduate:      return "Graduate"
            }
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch self{
        case .undergraduate: UGView()
        case .graduate:      GRView()
        }
    }
}
