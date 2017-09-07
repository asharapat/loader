//
//  SongModel.swift
//  loader
//
//  Created by Saulebekov Azamat on 06.09.17.
//  Copyright © 2017 Saulebekov Azamat. All rights reserved.
//

import Foundation
import SwiftyJSON
struct Song {
    var title:String
    var artist: String
    var url:URL
    
    init(title: String, artist: String, url: URL) {
        self.title = title
        self.artist = artist
        self.url = url
    }
    
    static func dataFrom(_ data: JSON) -> Song{
        let title = data["title"].stringValue
        let artist = data["artist"].stringValue
        let urlS = data["url"].url!
        let result = Song(title: title, artist: artist, url: urlS)
        return result
    }
}
