//
//  ViewControllerTableViewCell.swift
//  loader
//
//  Created by Saulebekov Azamat on 17.08.17.
//  Copyright © 2017 Saulebekov Azamat. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var pesnya: UILabel!
  
    @IBOutlet weak var pevets: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var downloadBtn: UIButton!
    
    
    
    static var shared = ViewControllerTableViewCell()
    
    
    var url: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.progressBar.progress = 0
        NotificationCenter.default.addObserver(self, selector: #selector(onDownloadProgress(notification:)), name: DownloadManager.Notifications.downloadProgress, object: nil)
    }
    
    func onDownloadProgress(notification: Notification) {
        guard let url = notification.userInfo?["url"] as? URL, let progress = notification.userInfo?["progress"] as? Float, let currentUrl = self.url, currentUrl.absoluteString == url.absoluteString else { return }
//        print(progress)
        DispatchQueue.main.async {
            self.progressBar.isHidden = false
            self.downloadBtn.isSelected = true
            self.progressBar.setProgress(progress, animated: true)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
