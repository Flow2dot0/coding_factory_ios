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
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var btnDepart: UIButton!
    @IBOutlet weak var switchAutoDark: UISwitch!
    @IBOutlet weak var switchManualDark: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SettingsController.isTrue(key: "autoDarkMode") {
            switchManualDark.isEnabled = false;
        }
        
        switchAutoDark.isOn = SettingsController.isTrue(key: "autoDarkMode");
        switchManualDark.isOn = SettingsController.isTrue(key: "darkMode");
        
        var langue = "";
        
        switch SettingsController.get(key: "langue")
        {
        case "en":
            langue = "English"
        case "fr":
            langue = "Français"
        default:
            langue = "Walof"
        }
        
        switch SettingsController.get(key: "map")
        {
        case "3d":
            btnMap.selectedSegmentIndex = 1;
        case "satellite":
            btnMap.selectedSegmentIndex = 2;
        default:
            btnMap.selectedSegmentIndex = 0;
        }
        
        
        changeLabelText(btn: btnLanguage, text: langue)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func switchManualDarkPressed(_ sender: Any) {
        if switchManualDark.isOn {
            overrideUserInterfaceStyle = .dark
            SettingsController.set(val: true, key: "darkMode")
        }else {
            overrideUserInterfaceStyle = .light
            SettingsController.set(val: false, key: "darkMode")
        }
        
    }
    
    @IBAction func switchAutoDarkPressed(_ sender: Any) {
        var auto : Bool = false;
        if !switchAutoDark.isOn {
            
            SettingsController.set(val: false, key: "darkMode")
            switchManualDark.isEnabled = true;


        }
        else {
            auto = true;
            switchManualDark.isEnabled = false;

            switchManualDark.setOn(false, animated: true)
            overrideUserInterfaceStyle = .light
            SettingsController.set(val: false, key: "darkMode")

        }
        print(auto);

        SettingsController.set(val: auto, key: "autoDarkMode")
        

        
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
    @IBAction func btnChangeLanguage(_ sender: Any) {
        var langue : String = SettingsController.get(key: "langue");
        let otherAlert = UIAlertController(title: SettingsController.get(key: "langue"), message: "Il se pourrait que vous devriez redémarrer l'application.", preferredStyle: UIAlertController.Style.actionSheet)

        let fr = UIAlertAction(title: "Français", style: UIAlertAction.Style.default) { _ in
            self.changeLabelText(btn: self.btnLanguage, text: "Français")
            langue = "fr";
            SettingsController.set(val: langue, key: "langue");

            
        }
        
        let en = UIAlertAction(title: "English", style: UIAlertAction.Style.default) { _ in
            self.changeLabelText(btn: self.btnLanguage, text: "English")
            langue = "en";
            SettingsController.set(val: langue, key: "langue");



        }
        
        let wf = UIAlertAction(title: "Walof", style: UIAlertAction.Style.default) { _ in
            self.changeLabelText(btn: self.btnLanguage, text: "Walof")
            langue = "wf";
            

        }

        // relate actions to controllers
        otherAlert.addAction(en)
        otherAlert.addAction(fr)
        otherAlert.addAction(wf)
        
        
        present(otherAlert, animated: true, completion: nil)
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
