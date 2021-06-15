//
//  HomeViewModel.swift
//  Weather
//
//  Created by Karan T Rai on 13/06/21.
//

import Foundation

protocol WeatherDataProtocol: AnyObject {
    func weatherReportRecieved()
}

class HomeViewModel: WeatherReportParsedProtocol {

    var weatherReports = [String: WeatherReport]()
    var homeCityReport = WeatherReport()
    var favourites = [String]()
    var recentSearches = [String]()
    
    weak var delegate: WeatherDataProtocol?
    
    var count: Int {
        return weatherReports.count
    }
    
    var favCount: Int {
        return favourites.count
    }
    
    var recentSearchCount: Int {
        return recentSearches.count
    }
    
    var networkManager = NetworkManager()
    
    func fetchWeather(ofCityName: String) {
        networkManager.delegate = self
        networkManager.fetchWeather(city: ofCityName)
    }
    
    func homeCityWeatherDetail(atIndex: Int) -> String {
        
        if atIndex >= 0 && atIndex < weatherDiscriptionArray.count {
            let cityReport = homeCityReport
            
            let maxMinTemp = String("\(cityReport.minimumTemperature)" + "° - " + " \(cityReport.maximumTemperature)" + "°")
            let humidity = String("\(cityReport.humidity)" + " %")
            let pressure = String("\(cityReport.pressure)" + " psi")
            let discription = String("\(cityReport.weatherDescription[0])")
            let discriptionArray: [String] = [maxMinTemp, humidity, pressure, discription]

            return discriptionArray[atIndex]
        }else {
            return ""
        }
        
    }
    
    func recieveWeatherReport(weatherReport: WeatherReport) {
        
        self.homeCityReport = weatherReport
        self.weatherReports[homeCityReport.cityName] = weatherReport

        
        print(count)
        
        self.delegate?.weatherReportRecieved()
    }
    
    func addCurrentCityToFavourite() {
        let city: String = homeCityReport.cityName
        if !favourites.contains(city) {
            favourites.append(city)
            //print(favCount)
        }
    }
    
    func removeFromFavourite() {
        let city: String = homeCityReport.cityName
        if favourites.contains(city) {
            guard let removeIndex = favourites.firstIndex(of: city) else { return }
            favourites.remove(at: removeIndex)
            //print(favCount)
        }
    }
    
    func fetchFavouriteCity(atIndex: Int) -> WeatherReport {
        var cityWeatherReport = WeatherReport()
        if atIndex >= 0 && atIndex < favCount {
            let cityName = favourites[atIndex]
            if let wd = weatherReports[cityName] {
                cityWeatherReport = wd
            }
        }
        return cityWeatherReport
    }
    
    func isFavourite(cityName: String) -> Bool {
        if favourites.contains(cityName) {
            return true
        }else {
            return false
        }
    }
    
    func addRecentSearch() {
        let city: String = homeCityReport.cityName
        if !recentSearches.contains(city) {
            recentSearches.append(city)
            //print(favCount)
        }
    }
    
    func fetchRecentSearchCity(atIndex: Int) -> WeatherReport {
        
        var cityWeatherReport = WeatherReport()
        if atIndex >= 0 && atIndex < recentSearchCount {
            let cityName = recentSearches[atIndex]
            if let wd = weatherReports[cityName] {
                cityWeatherReport = wd
            }
        }
        return cityWeatherReport
    }
    
}
