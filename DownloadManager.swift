//
//  DownloadManager.swift
//  loader
//
//  Created by Saulebekov Azamat on 24.08.17.
//  Copyright © 2017 Saulebekov Azamat. All rights reserved.
//

import UIKit
import Alamofire


protocol DownloadManagerDelegate: class {
    func downloadProgress(_ progress: Float)
}



class DownloadManager {
    
    static var shared = DownloadManager()
    
//    struct Notifications {
//        static let downloadProgress = Notification.Name("downloadProgress")
//        static let downloadCompleted = Notification.Name("downloadCompleted")
//    }
    
    var delegate: DownloadManagerDelegate?
    
    var queue = [(URL, String)]()
    var isLoading = false
    
    //   https://vibze.github.io/downloadr-task/files/02%2030%20Minute%20Love%20Affair.mp3
    func download(url: URL,title: String){
        let url = url
        let name = "\(title).mp3"
        let name2 = name.replacingOccurrences(of: " ", with: "")
        let urlSring = "file:///Users/Azamat/Desktop/songs/\(name2)"
        let filePathURl = URL(string: urlSring)
        if isLoading {
            queue.append((url, title))
            return
        }
        
        self.isLoading = true
        
        Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            self.isLoading = false
            //print("\(title) is completed")
            if let first = self.queue.first {
                self.queue.removeFirst()
                self.download(url: first.0, title: first.1)
            }

            return (filePathURl!, [.createIntermediateDirectories])
        })
            .downloadProgress{ progress in
                print(self.queue.count)

                self.delegate?.downloadProgress(Float(progress.fractionCompleted))
                //print("Download Progress: \(progress.fractionCompleted)")
                
                //print("Download Progress: \(progress.fractionCompleted)")
//                NotificationCenter.default.post(name: Notifications.downloadProgress, object: self, userInfo: ["progress": Float(progress.fractionCompleted), "url": url])
        }
    }
}

   

