//
//  SettingsController.swift
//  where
//
//  Created by Leprohon cedric on 24/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import UIKit

class SettingsController {
    static func get(key : String) -> String {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.string(forKey: key) ?? "";
    }
    
    static func isTrue(key : String) -> Bool {
        print("key = ", key);
        print("value = ", UserDefaults.standard.bool(forKey: key));
        UserDefaults.standard.synchronize()

        return UserDefaults.standard.bool(forKey: key);
    }
    
    static func set(val : Any, key : String) {
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    
    static func isDarkModeEnabled() -> Bool {
        let stg = SettingsController.self;
        if(stg.isTrue(key: "autoDarkMode")) {
            return true;
        }else if(!stg.isTrue(key: "autoDarkMode") && stg.isTrue(key: "darkMode")) {
            return true;
        }else {
            return false;
        }
        
    }
    
}
