//
//  SettingsView.swift
//  where
//
//  Created by Leprohon cedric on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var btnMap: UISegmentedControl!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var darkMode: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        switch SettingsController.get(key: "map")
        {
        case "3d":
            btnMap.selectedSegmentIndex = 1;
        case "satellite":
            btnMap.selectedSegmentIndex = 2;
        default:
            btnMap.selectedSegmentIndex = 0;
        }
        
     
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func darkModeChange(_ sender: Any) {
        if(darkMode.selectedSegmentIndex == 0) {
            SettingsController.set(val: true, key: "autoDarkMode")
            SettingsController.set(val: false, key: "darkMode")
            switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                overrideUserInterfaceStyle = .light
                case .dark:
                overrideUserInterfaceStyle = .dark

            }
        }else if(darkMode.selectedSegmentIndex == 1) {
            SettingsController.set(val: false, key: "autoDarkMode")
            SettingsController.set(val: true, key: "darkMode")
            overrideUserInterfaceStyle = .dark

        }else {
            SettingsController.set(val: true, key: "autoDarkMode")
            SettingsController.set(val: false, key: "darkMode")
            overrideUserInterfaceStyle = .light

        }
    }
    
    @IBAction func btnMapPressed(_ sender: Any) {
        let selected = btnMap.selectedSegmentIndex;
        var map = "";
        
        switch selected {
        case 0:
            map = "2d"
        case 1:
            map = "3d"
        case 2:
            map = "satellite"
        default:
            map = "2d"
        }
        
        SettingsController.set(val: map, key: "map");
        print(map);
    }
    
    
    func changeLabelText(btn : UIButton, text : String) {
        btn.setTitle(text, for: .normal)
    }
    
  
    @IBAction func btnPressed(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }

}
