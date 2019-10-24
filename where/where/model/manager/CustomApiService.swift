//
//  CustomApiService.swift
//  where
//
//  Created by FLORIAN GUSTIN on 24/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//

import Foundation
import SwiftyJSON


class CustomApiService {
    
    static func getData(startCoord: String, endCoord: String, completion: @escaping (_ response: Any) -> Void) {
        let session = URLSession.shared
        
           let key: String = "5e83a030bf0f924bf2c8c0c5adccf866"

        let urlBis = URL(string: "https://developer.citymapper.com/api/1/traveltime/?startcoord=" + startCoord + "&endcoord=" + endCoord + "&time=2014-11-06T19%3A00%3A02-0500&time_type=arrival&key=" + key )!
        
        print(urlBis)
        

        let task = session.dataTask(with: urlBis) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
               //let json = try JSONSerialization.jsonObject(with: //data!, options: [])
                
               if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                let tryTmp = json["travel_time_minutes"]
                
                completion(tryTmp! as Any)
                }
                
            }catch {
                print("JSON error: (error.localizedDescription)")
            }
        }
        task.resume()
    }
}

