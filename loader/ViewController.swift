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



class ViewController: UITableViewController{
    
    
    
    var titles:[String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var artists: [String] = []{
        didSet {
            tableView.reloadData()
        }
    }
    
    var urls: [URL] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://vibze.github.io/downloadr-task/tracks.json").responseJSON { (response) -> Void in
           
            if let value = response.result.value{
                let json = JSON(value)
                let number = json["tracks"].count
                for i in 0..<number{
                      //print(json["tracks"][i]["title"].stringValue)
                    self.titles.append(json["tracks"][i]["title"].stringValue)
                    self.artists.append(json["tracks"][i]["artist"].stringValue)
                    self.urls.append(json["tracks"][i]["url"].url!)
                    
                }
//                for i in 0..<number{
//                    print(self.urls[i])
//                }
            }
            
        }
////        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBtn(notification:)), name: DownloadManager.Notifications.downloadCompleted, object: nil)
//
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.pesnya.text = titles[indexPath.row]
        cell.pevets.text = artists[indexPath.row]
        cell.url = urls[indexPath.row]
        return (cell)
    }
    
    
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            if let indexPath = tableView.indexPath(for: sender.superview!?.superview as! UITableViewCell) {
                DownloadManager.shared.download(url: urls[indexPath.row], title: titles[indexPath.row])
            }
        } else {
            //            (sender as! UIButton).setTitle("Удалить", for: UIControlState.normal)
            if let indexPath = tableView.indexPath(for: sender.superview!?.superview as! UITableViewCell) {
                let name = "\(titles[indexPath.row]).mp3"
                let name2 = name.replacingOccurrences(of: " ", with: "")
                let filePathURL = URL(string:"file:///Users/Azamat/Desktop/songs/\(name2)")
                do {
                    try FileManager.default.removeItem(at: filePathURL!)
                } catch {
                    print("Could not delete file: \(error)")
                }
            }
        }
        
    }
    
    
    func deleteBtn(notification: Notification){
        guard let url = notification.userInfo?["url"] as? URL, let progress = notification.userInfo?["progress"] as? Float, progress == 1.0 else { return }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

