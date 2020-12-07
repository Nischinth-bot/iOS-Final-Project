//
//  ViewController.swift
//  GammaApp
//
//  Created by user180610 on 11/29/20.
//  Copyright © 2020 Nischinth Murari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    let vc = segue.destination as? deepHouseController
        switch(segue.identifier){
        case "link2house":
            vc?.identifier = "Deep House"
        case "link2jazz":
            vc?.identifier = "Jazz"
        case "link2dub":
            vc?.identifier = "Hyperdub"
        default:
            return
        }
        
        
    }
    
    @IBAction func goToHouseView(_ sender: UIButton) {
        performSegue(withIdentifier: "link2house", sender: self)
        
    }
}

