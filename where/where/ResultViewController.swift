//
//  ResultViewController.swift
//  where
//
//  Created by Leprohon cedric on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var coordEnd: String = ""
    var sAddress: String = "Coding Factory, 22 avenue de la Porte de Champerret, Levallois"
    let startCoord: String = "48.886009%2C2.289127"
    
    var travelTimeDuration: Any = 0
    var duration: String = ""
    

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var Destination: UILabel!
    @IBOutlet weak var Duration: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.address.text = self.sAddress
        }
        DispatchQueue.main.async {
                   self.Duration.text = self.duration
               }
        DispatchQueue.main.async {
            self.Destination.text = self.coordEnd
        }
        print( self.duration, self.coordEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateTravelTime(startCoord: self.startCoord, endCoord: self.coordEnd)
    }
    
    func calculateTravelTime(startCoord: String, endCoord: String) {
        CustomApiService.getData(startCoord: startCoord, endCoord: endCoord) { (data) in
            self.travelTimeDuration = data
            self.duration = (data as? String)!
        //wait for set
           }

    }
    
    
    


}

