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
        let preview = QLPreviewView(frame: .zero, style: .normal)
        preview?.autostarts = true
//        preview?.previewItem = URL(string: url)! as QLPreviewItem
        //if preview != nil { updatePreview(preview: preview!) }
        return preview ?? QLPreviewView()
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
                    print("setting preview")
                    // this is a hack to check whether QLPreview has closed
                    // might not be statble
                    if preview.superview != nil {
                        preview.previewItem = murl as QLPreviewItem
                    }
                }
            }
        }
    }
    
    static func dismantleNSView(_ nsView: QLPreviewView, coordinator: ()) {
        nsView.close()
    }
    

    typealias NSViewType = QLPreviewView

}
