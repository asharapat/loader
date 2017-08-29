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
    var queue: [URL?] = []
    
    
    
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
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(checkQueue(notification:)), name: DownloadManager.Notifications.downloadCompleted, object: nil)
        
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
        if let indexPath = tableView.indexPath(for: sender.superview!?.superview as! UITableViewCell) {
            self.queue.append(urls[indexPath.row])
            
            
            //DownloadManager.shared.download(url: urls[indexPath.row], title: titles[indexPath.row])
        }
        
    }
    
    
//    func checkQueue(notification: Notification){
//        guard let url = DownloadManager.shared.queue[0], let title = DownloadManager.shared.titles[0] else{return}
//        DownloadManager.shared.download(url: url, title: title)
//        
//        DownloadManager.shared.queue.remove(at: 0)
//        DownloadManager.shared.titles.remove(at: 0)
//        
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

