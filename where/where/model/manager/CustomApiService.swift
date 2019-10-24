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
    
    static func getData(string: String, completion: @escaping (_ response: Any) -> Void) {
        let session = URLSession.shared
        let link: String = "https://developer.citymapper.com/api/1/traveltime/?"
        let startCoord: String = "48.886009%2C2.289127"
        let endCoord: String = "48.896325%2C2.291561"
        let time: String = "2014-11-06T19%3A00%3A02-0500"
        let timeType: String = "arrival"
        let key: String = "6c69c29aee0df15279aac830461a2976"
        
        let url = URL(string: "https://developer.citymapper.com/api/1/traveltime/?startcoord=48.886009%2C2.289127&endcoord=48.896325%2C2.291561&time=2014-11-06T19%3A00%3A02-0500&time_type=arrival&key=6c69c29aee0df15279aac830461a2976")!

        let urlBis = URL(string: link + "startcoord=" + startCoord + "&endcoord=" + endCoord + "&time=" + time + "&time_type=" + timeType + "&key=" + key )!
        print(url)
        

        let task = session.dataTask(with: url) { data, response, error in

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
                print(tryTmp!)
                }
                
                

            }catch {
                print("JSON error: (error.localizedDescription)")
            }
        }
        task.resume()
    }
}

