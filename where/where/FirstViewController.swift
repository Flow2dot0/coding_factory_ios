//
//  FirstViewController.swift
//  where
//
//  Created by Leprohon cedric on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var lblTitle : UILabel!
    
    let startCoord: String = "48.886009%2C2.289127"
    let endCoord: String = "48.896325%2C2.291561"
    
    var travelTimeDuration: Any = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //lblTitle.text = NSLocalizedString("title_text", comment: "")
        calculateTravelTime(startCoord: self.startCoord, endCoord: self.endCoord)
    }
    
    func calculateTravelTime(startCoord: String, endCoord: String) {
        CustomApiService.getData(startCoord: startCoord, endCoord: endCoord) { (data) in
            self.travelTimeDuration = data
            print(self.travelTimeDuration)
        //wait for set
           }

    }
    


}

