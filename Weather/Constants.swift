//
//  Constants.swift
//  Weather
//
//  Created by Karan T Rai on 14/06/21.
//

import UIKit

let weatherDiscriptionArray = ["Max-Min", "Humidity", "Pressure", "Discription"]
let weatherDiscriptionImageArray = [UIImage(named: "temperature"), UIImage(named: "humidity"), UIImage(named: "pressure"),UIImage(named: "slightrain")]

enum SegueIdentifiers: String {
    case recentSearch = "RecentSearch"
    case favourites = "favourites"
}

enum TableViewTitle: String {
    case recentSearch = "Recent Search"
    case favourites = "Favourite"
}
