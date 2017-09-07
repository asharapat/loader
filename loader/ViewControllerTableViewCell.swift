//
//  ViewControllerTableViewCell.swift
//  loader
//
//  Created by Saulebekov Azamat on 17.08.17.
//  Copyright © 2017 Saulebekov Azamat. All rights reserved.
//

import UIKit
import Alamofire

protocol ViewControllerTableViewCellDelegate: class {
    func didTouchButtonAt(_ indexPath: IndexPath)
}

class ViewControllerTableViewCell: UITableViewCell{

    @IBOutlet weak var pesnya: UILabel!
  
    @IBOutlet weak var pevets: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    weak var delegate: ViewControllerTableViewCellDelegate?
    var indexPath:IndexPath?
    var progress: Float = 0{
        didSet {
            downloadingProgress()
        }
    }
    var song: String = " " {
        didSet {
            self.pesnya.text = song
            self.layoutIfNeeded()
        }
    }
    var singer: String = " "{
        didSet{
            self.pevets.text = singer
        }
    }
    
    
    @IBAction func downloadButtonTouched(sender: Any){
        self.delegate?.didTouchButtonAt(self.indexPath!)
        self.progressBar.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.progressBar.progress = 0
    }
    
//    func onDownloadProgress(notification: Notification) {
//        guard let url = notification.userInfo?["url"] as? URL, let progress = notification.userInfo?["progress"] as? Float, let currentUrl = self.url, currentUrl.absoluteString == url.absoluteString else { return }
////        print(progress)
//        DispatchQueue.main.async {
//            self.progressBar.isHidden = false
//           // self.downloadBtn.isSelected = true
//            self.progressBar.setProgress(progress, animated: true)
//        }
//        
//    }
    
    func downloadingProgress(){
        DispatchQueue.main.async {
            self.progressBar.setProgress(self.progress, animated: true)
        }
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
