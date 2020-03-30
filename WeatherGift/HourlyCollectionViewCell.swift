//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by Matthew Spana on 3/30/20.
//  Copyright © 2020 Matthew Spana. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var hourlyTemperature: UILabel!
    @IBOutlet weak var hourlyPrecipProbability: UILabel!
    @IBOutlet weak var raindropImageView: UIImageView!
    
    var systemWeatherIcons = ["clear-day": "sun.max",
                              "clear-night": "moon",
                              "cloudy": "cloud",
                              "fog": "cloud.fog",
                              "partly-cloudy-day": "cloud.sun",
                              "partly-cloudy-night": "cloud.moon",
                              "rain": "cloud.rain",
                              "snow": "cloud.snow",
                              "sleet": "cloud.sleet",
                              "wind": "wind"]
    
    var hourlyWeather: HourlyWeather! {
        didSet {
            hourlyLabel.text = hourlyWeather.hour
            iconImageView.image = UIImage(systemName: systemWeatherIcons[hourlyWeather.hourlyIcon]!)
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)°"
            hourlyPrecipProbability.text = "\(hourlyWeather.hourlyProbability)%"
            if hourlyWeather.hourlyProbability >= 20 {
                hourlyPrecipProbability.isHidden = false
                raindropImageView.isHidden = false
            } else {
                hourlyPrecipProbability.isHidden = true
                raindropImageView.isHidden = true
            }
        }
    }
}
