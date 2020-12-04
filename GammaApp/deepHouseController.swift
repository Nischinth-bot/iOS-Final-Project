//
//  deepHouseController.swift
//  GammaApp
//
//  Created by user180610 on 11/29/20.
//  Copyright © 2020 Nischinth Murari. All rights reserved.
//

import UIKit
import WebKit

class deepHouseController: UIViewController {

    let artists = ["Kerri%20Chandler", "Theo%20Parrish", "DJ%20Steaw", "Janeret", "Frankie%20Kunckles", "Lauren%20Lo%20Sung", "DJ%Pierre"]
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let chosenOne = artists[Int.random(in: 1..<artists.count)]
        let apiKey = "AIzaSyCozKD1dSLnwhM-d_246aDlohMXO9hKv5w"
        let session = URLSession.shared
        let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=\(chosenOne)&key=\(apiKey)")
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
                if let items = json!["items"] as? Array<Dictionary<String,Any>>{
                    for item in items{
                        print(item)
                    }
                    
                }
                //print(json)
            } catch {
                print("JSON error :\(error)")
            }
            
        }
        task.resume()
        // Do any additional setup after loading the view.
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
