//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "FFmWrUywnQqpP2ghtaSueWITqA8lIynxFH1BY5dEk3vkqJW8exT-ZAFT2IofKFG6pOTmjA6gLlZ9ZjTaf25t-9eavuZPSSLyySww6fXVDpHZLp0fW3hSSUWdNRP7YXYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // ––––– TODO: Get data from API and return it using completion
                
                // 1. Traverse the data in json format and convert it to a dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // 2. From the dictionary, the "businesses" value is an array of businesses, so we convert it to an array of dictionaries that represent the data of each restaurant
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
                
                // 3. (Completion is an escaping method which allows the data to be used outside of the closure) Return the array of dictionaries reporesenting the restaurants
                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

    
