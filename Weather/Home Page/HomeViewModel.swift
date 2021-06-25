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
    
    var favCopy = [String]()
    var recentSearchCopy = [String]()
    
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
        // (Int.getDateDiff(start: weatherReport.storedTime ?? Date(), end: Date()) <= 1800)
        if let weatherReport = weatherReports[ofCityName], (weatherReport.storedTime - Date().millisecondsSince1970 <= (30 * 60 * 1000)) {
            self.homeCityReport = weatherReport
        }else {
            networkManager.fetchWeather(url: String.urlFromCityName(cityName: ofCityName))
        }
    }
    
    func fetchWeather(coordinates: Coordinates) {
        networkManager.delegate = self
        
        networkManager.fetchWeather(url: String.urlFromCoordinates(coordinates: coordinates))
        
    }
    
    func homeCityWeatherDetail(atIndex: Int) -> String {
        
        if atIndex >= 0 && atIndex < weatherDiscriptionArray.count {
            let cityReport = homeCityReport
            
            let maxMinTemp = String("\(Int(cityReport.minimumTemperature))" + "° - " + " \(Int(cityReport.maximumTemperature))" + "°")
            let humidity = String("\(cityReport.humidity)" + " %")
            let pressure = String("\(cityReport.pressure)" + " hpa")
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
        
        self.saveWeatherReport()

        self.delegate?.weatherReportRecieved()
        
    }
    
    func addCurrentCityToFavourite() {
        let city: String = homeCityReport.cityName
        if !favourites.contains(city) {
            favourites.append(city)
            favCopy.append(city)
            //print(favCount)
        }
    }
    
    func removeFromFavourite() {
        
        let city: String = homeCityReport.cityName
        if favourites.contains(city) {
            guard let removeIndex = favourites.firstIndex(of: city) else { return }
            favourites.remove(at: removeIndex)
            favCopy.remove(at: removeIndex)
            //print(favCount)
        }
    }
    
    func removeCityFromFavourite(atIndex: Int) {
        
        if atIndex >= 0 && atIndex < favCount {
            favourites.remove(at: atIndex)
            favCopy.remove(at: atIndex)
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
        
        return favourites.contains(cityName)
         
    }
    
    func addRecentSearch(cityName: String) {
        
        let city: String = cityName
        if !recentSearches.contains(city) {
            recentSearches.append(city)
            recentSearchCopy.append(city)
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
    
    func addRecentToFavourite(ofIndex: Int) {
        
        if ofIndex >= 0 && ofIndex < recentSearchCount {
            let city: String = recentSearches[ofIndex]
            if !favourites.contains(city) {
                favourites.append(city)
                favCopy.append(city)
            }
        }
    }
    
    func retriveFavourites() {
        self.favourites = self.favCopy
    }
    
    func retrieveRecentSearch() {
        self.recentSearches = self.recentSearchCopy
    }
    
    func clearRecentSearch() {
        self.recentSearches.removeAll()
        self.recentSearchCopy.removeAll()
    }
    
    func clearFavourites() {
        self.favourites.removeAll()
        self.favCopy.removeAll()
    }
    
}

extension HomeViewModel {
    
    func accountStorePath() -> URL {
        
        return URL.weatherReportPath()
    }
    
    func favouriteStorePath() -> URL {
        
        return URL.favouriteStorePath()
    }
    
    func recentSearchStorePath() -> URL {
        
        return URL.recentSearchStorePath()
    }
    
    func saveWeatherReport() {
        do{
            let accountData = try NSKeyedArchiver.archivedData(withRootObject: self.weatherReports, requiringSecureCoding: false)
            let favouriteData = try NSKeyedArchiver.archivedData(withRootObject: self.favCopy, requiringSecureCoding: true)
            let recentSearchData = try NSKeyedArchiver.archivedData(withRootObject: self.recentSearchCopy, requiringSecureCoding: true)
            
            try accountData.write(to: self.accountStorePath())
            try favouriteData.write(to: self.favouriteStorePath())
            try recentSearchData.write(to: self.recentSearchStorePath())
            print(self.weatherReports.count)
            print(self.favCopy.count)
        }catch {
            // in case of failure
            print("unable to access the file or file does not exist")
        }
    }
    
    func loadWeatherReport() {
        do {
            print("url retrieved")
            let weatherData = try Data(contentsOf: self.accountStorePath())
            let favouriteData = try Data(contentsOf: self.favouriteStorePath())
            let recentSearchData = try Data(contentsOf: self.recentSearchStorePath())
            
            if let weatherReports = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(weatherData) as? [String : WeatherReport],
               let favouritesLoded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(favouriteData) as? [String],
               let recentSearchLoded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(recentSearchData) as? [String] {
                print(weatherReports.count)
                self.weatherReports = weatherReports
                self.favCopy = favouritesLoded
                self.favourites = favouritesLoded
                self.recentSearchCopy = recentSearchLoded
                self.recentSearches = recentSearchLoded
            }
        }catch {
            print("weather report not found")
        }
    }
}

