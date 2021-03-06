//
//  String+extension.swift
//  Weather
//
//  Created by Karan T Rai on 16/06/21.
//

import Foundation

extension String {
    
    static func urlFromCityName(cityName: String) -> String {
        let url: String = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=\(String.myApiId())&units=metric"
        return url
    }
    
    static func urlFromCoordinates(coordinates: Coordinates) -> String {
        let url: String = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&APPID=\(String.myApiId())&units=metric"
        return url
    }
    
    static func myApiId() -> String {
        return "c08343e858ea297377f74323e8b5de03"
    }
    
    static func favouriteListDisplay(favCount: Int) -> String {
        return "\(favCount) City added as favourite"
    }
    
    static func recentListDisplay() -> String {
        return "You recently searched for"
    }
    
    static func noRecentSearch() -> String {
        return "No Recent Search"
    }
    
    static func noFavourites() -> String {
        return "No Favourites added"
    }
    
        
}
