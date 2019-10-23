//
//  FirstViewController.swift
//  where
//
//  Created by Leprohon cedric on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var manager = MapDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch(string: "https://httpbin.org/headers") { (data) in
            print("FirstViewController closure")
        }
        // Do any additional setup after loading the view.
    }


}

