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
                for i in 0..<number{
                    print(self.urls[i])
                }
                
            }
            
        }
        
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
        
        return (cell)
    }
    
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        if let cell = sender.superview??.superview as? ViewControllerTableViewCell{
            let indexPath = tableView.indexPath(for: cell)
            //print(self.titles[(indexPath?.row)!])
            let url = self.urls[(indexPath?.row)!]
            let urlSring = "file:///Users/Azamat/Desktop/images/onel1.mp3"
            let filePathURl = URL(string: urlSring)
            Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                    return (filePathURl!, [.createIntermediateDirectories])})
                        .downloadProgress{ progress in
                        print("Download Progress: \(progress.fractionCompleted)")
                        cell.progressBar.progress = Float(progress.fractionCompleted)
            }
        }
        
    }

    
    
    
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let url = urls[indexPath.row]
//        let urlSring = "file:///Users/Azamat/Desktop/images/onel1.mp3"
//        let filePathURl = URL(string: urlSring)
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
//        
//        Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
//            return (filePathURl!, [.createIntermediateDirectories])
//        })
//            .downloadProgress{ progress in
//                print("Download Progress: \(progress.fractionCompleted)")
//                cell.progressBar.progress = Float(progress.fractionCompleted)
//            }
////            .responseData { response in
////                if let data = response.result.value {
////                    self.imageView.image = UIImage(data: data)
////                }
////                }
//    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

