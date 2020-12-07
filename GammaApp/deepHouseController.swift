//
//  deepHouseController.swift
//  GammaApp
//
//  Created by user180610 on 11/29/20.
//  Copyright © 2020 Nischinth Murari. All rights reserved.
//

import UIKit
import WebKit

class deepHouseController: UIViewController, UIGestureRecognizerDelegate {

    var identifier: String = ""
    @IBOutlet weak var webView: WKWebView!
    let foo = WKWebView()
    let deepHouse = ["Kerri%20Chandler", "Theo%20Parrish", "DJ%20Steaw", "Janeret", "Frankie%20Kunckles", "dj%20pierre%20acid", "larry%20heard", "rutilance%20recordings", "chikyu-u%20records", "taro%20asama", "ortella","berlin%20house%20music"]
    let jazz = ["Miles%20Davis","John%20Coltrane", "Charles%20Mingus","Art%20blakey","Donald%20Byrd", "Alice%20Coltrane"]
    let dub = ["Burial","hyperdub", "dj%20rashad", "dj%20spinn%20hyperdub"]
    var tracksToChoose:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONAndLoadVideo()

        // Do any additional setup after loading the view.
    }
    
    //Function to play a random video on YouTube from a collection of links
    func playRandomSong(_  trackList: [String]){
        let size = trackList.count
        let chosenSong = trackList[Int.random(in: 1..<size)]
        if let url = URL(string: "https://www.youtube.com/watch?v=\(chosenSong)")
        {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        else {
            print("URL not found")
        }
    }
    
    func getJSONAndLoadVideo()
    {
        var artistCluster: [String] = getArtistCluster(identifier: self.identifier)
        let chosenArtist = artistCluster[Int.random(in: 1..<artistCluster.count)]
        let apiKey = "AIzaSyDDo_KTjSJhP-S2w32QRVDpWLQ0-kRslMo"
        let session = URLSession.shared
        let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=100&q=\(chosenArtist)&key=\(apiKey)")
        let task = session.dataTask(with: url!){ data,response,error in
            
            if error != nil || data == nil{
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
              }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                if let dataArray = json!["items"] as? Array<Dictionary<String,Any>>{
                    for object in dataArray{
                        if let dictionary = object as? [String: Any]{
                            let idDetails = dictionary["id"] as! [String:String]
                            let videoID = idDetails["videoId"]
                            if(videoID != nil) {self.tracksToChoose.append(videoID!)}
                        }
                    }
                    self.playRandomSong(self.tracksToChoose)
                }
                //print(json)
            } catch {
                print("JSON error :\(error)")
            }
            
        }
        
        while(task == nil){ usleep(1)}
        task.resume()
    }
    
    func getArtistCluster(identifier: String) -> [String]{
        switch identifier{
        case "Deep House":
            return self.deepHouse
        case "Jazz":
            return self.jazz
        case "Hyperdub":
            return self.dub
        default:
            return [ ]
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
