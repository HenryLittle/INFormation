//
//  DownloadUtils.swift
//  INFormation
//
//  Created by 林柯舟 on 2020/11/24.
//

import Foundation

class DownloadUtils{
    static func downloadFile(from url: URL, to dir: URL = FileManager.default.temporaryDirectory,
                             withName filename: String, completion: @escaping (_ fileUrl: URL?) -> Void) {
        let destinationUrl = dir.appendingPathComponent(filename)
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            completion(destinationUrl)
        } else {
            URLSession.shared.downloadTask(with: url) {
                location, response, error in
                guard let tempLocation = location, error == nil else {
                    return
                }
                do {
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    completion(destinationUrl)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }.resume()
        }
    }
}
