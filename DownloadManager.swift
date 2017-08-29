//
//  DownloadManager.swift
//  loader
//
//  Created by Saulebekov Azamat on 24.08.17.
//  Copyright © 2017 Saulebekov Azamat. All rights reserved.
//

import UIKit
import Alamofire



class DownloadManager {
    
    static var shared = DownloadManager()
    
    struct Notifications {
        static let downloadProgress = Notification.Name("downloadProgress")
        static let downloadCompleted = Notification.Name("downloadCompleted")
    }
    
     //   https://vibze.github.io/downloadr-task/files/02%2030%20Minute%20Love%20Affair.mp3
    func download(url: URL,title: String){
        //print("------ =[[ \(urls.count)")
            let url = url
            let name = "\(title).mp3"
            let name2 = name.replacingOccurrences(of: " ", with: "")
            let urlSring = "file:///Users/Azamat/Desktop/songs/\(name2)"
            let filePathURl = URL(string: urlSring)
        //print(name2)
        Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            return (filePathURl!, [.createIntermediateDirectories])
        })
            .downloadProgress{ progress in
                print("Download Progress: \(progress.fractionCompleted)")
                NotificationCenter.default.post(name: Notifications.downloadProgress, object: self, userInfo: ["progress": Float(progress.fractionCompleted), "url": url])
                if progress.fractionCompleted == 1.0{
                    NotificationCenter.default.post(name: Notifications.downloadCompleted, object: self, userInfo: ["progress": Float(progress.fractionCompleted),"url": url])
                }
        }
    }
}
   

