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
    
    
//    @IBAction func buttonPressed(_ sender: Any) {
//        
//    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progressBar.progress = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
