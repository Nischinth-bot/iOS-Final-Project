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

    
    @IBAction func goToHouseView(_ sender: UIButton) {
        performSegue(withIdentifier: "link2house", sender: self)
    }
}

