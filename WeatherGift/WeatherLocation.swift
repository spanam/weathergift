//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Matthew Spana on 3/23/20.
//  Copyright © 2020 Matthew Spana. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
        // Note: will work for any api URL
        let coordinates = "\(latitude),\(longitude)"
        let urlString = "\(APIurls.darkSkyURL)\(APIKeys.darkSkyKey)/\(coordinates)"
        
//        let urlString = "https://pokeapi.co/api/v2/pokemon/"
        
        print("\(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create url from \(urlString)")
            return
        }
        
        // Create Session
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            // note: there are additional things that can go wrong, but we will ignore them for simplicity and because they're unlikely
            
            do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
        
    }
    
}
