//
//  DailyTableViewCell.swift
//  WeatherGift
//
//  Created by Matthew Spana on 3/30/20.
//  Copyright © 2020 Matthew Spana. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailySummaryLabel: UITextView!
    @IBOutlet weak var dailyLowLabel: UILabel!
    
    var systemWeatherIcons = ["clear-day": "sun.max",
                              "clear-night": "moon.fill",
                              "cloudy": "cloud",
                              "fog": "cloud.fog",
                              "partly-cloudy-day": "cloud.sun",
                              "partly-cloudy-night": "cloud.moon.fill",
                              "rain": "cloud.rain",
                              "snow": "cloud.snow",
                              "sleet": "cloud.sleet",
                              "wind": "wind"]
    
    var dailyWeather: DailyWeather! {
        didSet {
            dailyImageView.image = UIImage(systemName: systemWeatherIcons[dailyWeather.dailyIcon]!)
            dailyWeekdayLabel.text = dailyWeather.dailyWeekday
            dailySummaryLabel.text = dailyWeather.dailySummary
            dailyHighLabel.text = "\(dailyWeather.dailyHigh)"
            dailyLowLabel.text = "\(dailyWeather.dailyLow)"
        }
    }
    
    
}
