//
//  ApiService.swift
//  where
//
//  Created by FLORIAN GUSTIN on 23/10/2019.
//  Copyright © 2019 Elite. All rights reserved.
//


import Foundation

class ApiService {
    private static let customUrl = URL(string: "https://developer.citymapper.com/api/1/traveltime/?")!
    
    static func getData(){
        var request = URLRequest(url: customUrl)
        request.httpMethod = "POST"
        
        let body = "startcoord=48.886009%2C2.289127&endcoord=48.896325%2C2.291561&time=2014-11-06T19%3A00%3A02-0500&time_type=arrival&key=6c69c29aee0df15279aac830461a2976"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                    let text = responseJSON["quoteText"],
                        let author = responseJSON["quoteAuthor"] {
                        print(text)
                        print(author)
                    }
                }
            }
        }
        task.resume()
    }
}
