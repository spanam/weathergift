//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Matthew Spana on 3/29/20.
//  Copyright © 2020 Matthew Spana. All rights reserved.
//

import Foundation

private let dateFormatter: DateFormatter = {
    print("Date Formatter Created in WeatherDetail.swift")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
}()

struct DailyWeatherData: Codable {
    var dailyIcon: String
    var dailyWeekday: String
    var dailySummary: String
    var dailyHigh: Int
    var dailyLow: Int
}

class WeatherDetail: WeatherLocation {
    
    
    
    private struct Result: Codable {
        var timezone: String
        var currently: Currently
        var daily: Daily
    }
    
    private struct Currently: Codable {
        var temperature: Double
        var time: TimeInterval
    }
    
    private struct Daily: Codable {
        var summary: String
        var icon: String
        var data: [DailyData]
    }
    
    private struct DailyData: Codable {
        var icon: String
        var time: TimeInterval
        var summary: String
        var temperatureHigh: Double
        var temperatureLow: Double
    }
    
    var timezone = ""
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    var currentTime = 0.0
    var dailyWeatherData: [DailyWeatherData] = []
    
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
                for index in 0..<result.daily.data.count {
                    let weekdayDate = Date(timeIntervalSince1970: result.daily.data[index].time)
                    dateFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let dailyWeekday = dateFormatter.string(from: weekdayDate)
                    let dailyIcon = result.daily.data[index].icon
                    let dailySummary = result.daily.data[index].summary
                    let dailyHigh = Int(result.daily.data[index].temperatureHigh)
                    let dailyLow = Int(result.daily.data[index].temperatureLow)
                    let dailyWeather = DailyWeatherData(dailyIcon: dailyIcon, dailyWeekday: dailyWeekday, dailySummary: dailySummary, dailyHigh: dailyHigh, dailyLow: dailyLow)
                    self.dailyWeatherData.append(dailyWeather)
                    print("Day: \(dailyWeather.dailyWeekday) High: \(dailyWeather.dailyHigh) Low \(dailyWeather.dailyLow)")
                }
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
            
        }
        
        task.resume()
        
    }
    
}