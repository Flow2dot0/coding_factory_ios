//
//  MapDataManager.swift
//  where
//
//  Created by FLORIAN GUSTIN on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import Foundation
import Alamofire

class MapDataManager: NSObject{
    
    
    func fetch(string: String, completion: @escaping (_ response: Data) -> Void) {
                
        Alamofire.request(string).responseJSON { response in
            
            completion(response.data!)
            print(response)
        }

    }
    
}
