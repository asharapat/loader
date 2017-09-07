//
//  ViewController.swift
//  loader
//
//  Created by Saulebekov Azamat on 17.08.17.
//  Copyright © 2017 Saulebekov Azamat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UITableViewController, ViewControllerTableViewCellDelegate, DownloadManagerDelegate{
    
    var getProgress: Float?
    var selectedIndexPath: IndexPath?
    var songs:[Song] = []
    func shareProgress(progress: Float) {
        getProgress = progress
        //send to UIViewCell
    }
    
    
    var set = NSMutableSet()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://vibze.github.io/downloadr-task/tracks.json").responseJSON { (response) -> Void in
           
            if let value = response.result.value{
                self.songs = []
                let json = JSON(value)
                
                for obj in json["tracks"].arrayValue {
                        let song = Song.dataFrom(obj)
                        self.songs.append(song)
                }
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard (songs != nil) else {
            return 0
        }
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ViewControllerTableViewCell = {
            guard let cell: ViewControllerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell") as! ViewControllerTableViewCell
            }
            return cell
        }()
        
        let song = songs[indexPath.row]
        cell.song = (song.title)
        cell.singer = (song.artist)
      //  let url = URL(string: (song.url))
    //    cell.url = url
        cell.indexPath = indexPath
        cell.delegate = self
//        if(set.contains(titles[indexPath.row])){
//            cell.downloadButton.isSelected = true
//        }
//        else{
            cell.progressBar.progress = 0
            cell.progressBar.isHidden = true
//            cell.downloadButton.isSelected = false
//        }
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didTouchButtonAt(_ indexPath: IndexPath) {
        let selectedSong = self.songs[indexPath.row] as Song
        DownloadManager.shared.delegate = self
        self.selectedIndexPath = indexPath
        DownloadManager.shared.download(url: selectedSong.url , title: selectedSong.title)
        
    }
    func downloadProgress(_ progress: Float) {
        print(progress)
        let cell = self.tableView.cellForRow(at: selectedIndexPath!) as! ViewControllerTableViewCell
        cell.progress = progress
    }
}

