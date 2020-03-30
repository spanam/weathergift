//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Matthew Spana on 3/29/20.
//  Copyright © 2020 Matthew Spana. All rights reserved.
//

import Foundation

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var currently: Currently
        var daily: Daily
    }
    
    struct Currently: Codable {
        var temperature: Double
        var time: TimeInterval
    }
    
    struct Daily: Codable {
        var summary: String
        var icon: String
    }
    
    var timezone = ""
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    var currentTime = 0.0
    
    func getData(completed: @escaping () -> () ) {
        // Note: will work for any api URL
        let coordinates = "\(latitude),\(longitude)"
        let urlString = "\(APIurls.darkSkyURL)\(APIKeys.darkSkyKey)/\(coordinates)"
        
        //        let urlString = "https://pokeapi.co/api/v2/pokemon/"
        
        print("\(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create url from \(urlString)")
            completed()
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
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.temperature = Int(result.currently.temperature.rounded())
                self.summary = result.daily.summary
                self.dailyIcon = result.daily.icon
                self.currentTime = result.currently.time
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
            
        }
        
        task.resume()
        
    }
    
}
