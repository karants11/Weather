//
//  NetworkManager.swift
//  Weather
//
//  Created by Karan T Rai on 12/06/21.
//

import Foundation

protocol WeatherReportParsedProtocol: AnyObject {
    func recieveWeatherReport(weatherReport: WeatherReport)
}

class NetworkManager {
    
    weak var delegate: WeatherReportParsedProtocol?
    
    func fetchWeather(url: String) {
        
        
        guard let weatherURL = URL(string: url) else {
            return
        }
        
        // create session
        
        let session = URLSession.shared
        
        // create task
        
        let task = session.dataTask(with: weatherURL) {
            
            [weak self]
            (data, response, error)
            in
            print("Requested Complete")
            
            // check for error
            if error != nil {
                return
            }
            
            // check for response code
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                return
            }
            
            // check for data
            
            guard let weatherData = data else {
                return
            }
            
            // convert JSON data into as our data
            do {
                let weatherObj = try JSONSerialization.jsonObject(with: weatherData, options: [])
                
                if let weatherReport = self?.parseWeatherReport(weatherReport: weatherObj) {
                    self?.delegate?.recieveWeatherReport(weatherReport: weatherReport)
                }else {
                    self?.delegate?.recieveWeatherReport(weatherReport: WeatherReport())
                }
                
            }catch {
                print("json conversion failed")
            }

        }
        
        // execute the task
        
        task.resume()
    }
    
    func parseWeatherReport(weatherReport: Any) -> WeatherReport {
        var finalWeatherReport: WeatherReport = WeatherReport()
        
        guard let weatherReport = weatherReport as? [String: Any] else {
            return WeatherReport()
        }
                
        if let name = weatherReport["name"] as? String,
           let main = weatherReport["main"] as? [String : Any],
           let temperature = main["temp"] as? Double,
           let minimumTemperature = main["temp_min"] as? Double,
           let maximumTemperature = main["temp_max"] as? Double,
           let pressure = main["pressure"] as? Int,
           let humidity = main["humidity"] as? Int,
           let coordinates = weatherReport["coord"] as? [String : Any],
           let latitude = coordinates["lat"] as? Double,
           let longitude = coordinates["lon"] as? Double{
            
            let currentTime = Date()
            
            finalWeatherReport = WeatherReport(cityName: name, temperature: temperature, minimumTemperature: minimumTemperature, maximumTemperature: maximumTemperature, weatherDescription: [String](), pressure: pressure, humidity: humidity, latitude: latitude, longitude: longitude, storedTime: currentTime)
            
            var finalWeatherDescription = [String]()
            if let weathers = weatherReport["weather"] as? [[String : Any]] {
                for weather in weathers {
                    if let weatherDescrition = weather["main"] as? String {
                        finalWeatherDescription.append(weatherDescrition)
                    }
                }
                finalWeatherReport.weatherDescription = finalWeatherDescription
            }
        }
        return finalWeatherReport
    }
}
