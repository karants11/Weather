//
//  WeatherReport.swift
//  Weather
//
//  Created by Karan T Rai on 13/06/21.
//

import Foundation

class WeatherReport {
    
    var cityName: String
    var temperature: Double
    var minimumTemperature: Double
    var maximumTemperature: Double
    var weatherDescription: [String]
    var pressure: Int
    var humidity: Int
    var coordinates: Coordinates
    var storedTime: Date
    
    init(cityName: String, temperature: Double, minimumTemperature: Double, maximumTemperature: Double, weatherDescription: [String], pressure: Int, humidity: Int, latitude: Double, longitude: Double, storedTime: Date) {
        
        self.cityName = cityName
        self.temperature = temperature
        self.minimumTemperature = minimumTemperature
        self.maximumTemperature = maximumTemperature
        self.weatherDescription = weatherDescription
        self.pressure = pressure
        self.humidity = humidity
        self.coordinates = Coordinates(latitude: latitude, longitude: longitude)
        self.storedTime = storedTime
    }
    
    init() {
        self.cityName = ""
        self.temperature = 0
        self.minimumTemperature = 0
        self.maximumTemperature = 0
        self.weatherDescription = [String]()
        self.pressure = 0
        self.humidity = 0
        self.coordinates = Coordinates(latitude: 0, longitude: 0)
        self.storedTime = Date()
    }
}
