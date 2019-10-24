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
    var url = "https://developer.citymapper.com/api/1/traveltime/?startcoord=48.886009%2C2.289127&endcoord=48.896325%2C2.291561&time=2014-11-06T19%3A00%3A02-0500&time_type=arrival&key=6c69c29aee0df15279aac830461a2976"

    override func viewDidLoad() {
        super.viewDidLoad()
        CustomApiService.getData(string: url) { (data) in
            print(data)
               }

        // Do any additional setup after loading the view.
    }


}

