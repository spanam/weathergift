//
//  PageViewController.swift
//  WeatherGift
//
//  Created by Matthew Spana on 3/25/20.
//  Copyright © 2020 Matthew Spana. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        loadLocations()
        setViewControllers([createLocationDetailViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    func loadLocations() {
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data else {
            print("WARNING: Could not load Data. This will always be the case when the app is first run")
            //TODO: Get user location for first value
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 0.0, longitude: 0.0))
            return
        }
        let decoder = JSONDecoder()
        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
            self.weatherLocations = weatherLocations
        } else {
            print("ERROR: Couldn't decode data read from UserDefaults")
        }
        
        if weatherLocations.isEmpty {
            //TODO: Get user location for first value
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 0.0, longitude: 0.0))
        }
    }
    
    
    func createLocationDetailViewController(forPage page: Int) -> LocationDetailViewController {
        let detailViewController = storyboard!.instantiateViewController(identifier: "LocationDetailViewController") as! LocationDetailViewController
        detailViewController.locationIndex = page
        return detailViewController
    }
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController {
            if currentViewController.locationIndex > 0 {
                return createLocationDetailViewController(forPage: currentViewController.locationIndex - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController {
            if currentViewController.locationIndex < weatherLocations.count - 1 {
                return createLocationDetailViewController(forPage: currentViewController.locationIndex + 1)
            }
        }
        return nil
    }
}
