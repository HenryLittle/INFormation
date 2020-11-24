//
//  QLPreviewController.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import SwiftUI
import AppKit
import Quartz

struct MyPreview: NSViewRepresentable {
    var url: String
    var name: String
    var closed = true

    func makeNSView(context: NSViewRepresentableContext<MyPreview>) -> QLPreviewView {
        let preview = QLPreviewView()
        preview.autostarts = true
        return preview
    }

    func updateNSView(_ nsView: QLPreviewView, context: NSViewRepresentableContext<MyPreview>) {
        updatePreview(preview: nsView)
    }
    
    func updatePreview(preview: QLPreviewView) {
        guard let actualUrl = URL(string: url) else {
            return
        }
        DownloadUtils.downloadFile(from: actualUrl, withName: name) { fileUrl in
            if let murl = fileUrl {
                DispatchQueue.main.async {
                    // this is a hack to check whether QLPreview has closed
                    // not statble
                    if preview.isActivated {
                        preview.previewItem = murl as QLPreviewItem
                    }
                }
            }
        }
    }

    typealias NSViewType = QLPreviewView

}

extension QLPreviewView {
    var isActivated: Bool {
        let str = String(describing: self)
        return !str.contains("deactivated")
    }
}
