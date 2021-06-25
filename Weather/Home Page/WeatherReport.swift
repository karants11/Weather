//
//  WeatherReport.swift
//  Weather
//
//  Created by Karan T Rai on 13/06/21.
//

import Foundation

class WeatherReport: NSObject, NSCoding {
    
    var cityName: String
    var temperature: Double
    var minimumTemperature: Double
    var maximumTemperature: Double
    var weatherDescription: [String]
    var pressure: Int
    var humidity: Int
    var coordinates: Coordinates
    var storedTime: Int64
    
    init(cityName: String, temperature: Double, minimumTemperature: Double, maximumTemperature: Double, weatherDescription: [String], pressure: Int, humidity: Int, latitude: Double, longitude: Double, storedTime: Int64) {
        
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
    
    override init() {
        self.cityName = ""
        self.temperature = 0
        self.minimumTemperature = 0
        self.maximumTemperature = 0
        self.weatherDescription = [String]()
        self.pressure = 0
        self.humidity = 0
        self.coordinates = Coordinates(latitude: 0, longitude: 0)
        self.storedTime = 0
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.cityName, forKey: "cityName")
        coder.encode(self.temperature, forKey: "temperature")
        coder.encode(self.minimumTemperature, forKey: "minimumTemperature")
        coder.encode(self.maximumTemperature, forKey: "maximumTemperature")
        coder.encode(self.weatherDescription, forKey: "weatherDescription")
        coder.encode(self.pressure, forKey: "pressure")
        coder.encode(self.humidity, forKey: "humidity")
        coder.encode(self.coordinates, forKey: "coordinates")
        coder.encode(self.storedTime, forKey: "storedTime")
    }
    
    required init?(coder: NSCoder) {
        guard let cityName = coder.decodeObject(forKey: "cityName") as? String,
              let temperature = coder.decodeDouble(forKey: "temperature") as? Double,
              let minimumTemperature = coder.decodeDouble(forKey: "minimumTemperature") as? Double,
              let maximumTemperature = coder.decodeDouble(forKey: "maximumTemperature") as? Double,
              let weatherDescription = coder.decodeObject(forKey: "weatherDescription") as? [String],
              let pressure = coder.decodeInteger(forKey: "pressure") as? Int,
              let humidity = coder.decodeInteger(forKey: "humidity") as? Int,
              let coordinates = coder.decodeObject(forKey: "coordinates") as? Coordinates,
              let storedTime = coder.decodeInt64(forKey: "storedTime") as? Int64
        else {
            print("entering guard let")
            return nil
            
        }
        print("guard let succeding")
        
        self.cityName = cityName
        self.temperature = temperature
        self.minimumTemperature = minimumTemperature
        self.maximumTemperature = maximumTemperature
        self.weatherDescription = weatherDescription
        self.pressure = pressure
        self.humidity = humidity
        self.coordinates = coordinates
        self.storedTime = storedTime
    }
    
    
}
