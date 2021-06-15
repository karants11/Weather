//
//  LoacationManager.swift
//  Weather
//
//  Created by Karan T Rai on 15/06/21.
//

import UIKit
import CoreLocation

protocol cityNameRecieved {
    func cityNameRecieved(cityName: String)
}

class LoacationManager: NSObject, CLLocationManagerDelegate {
    var currentCoordinates: Coordinates
    
    let locationManager = CLLocationManager()

    override init() {
        self.currentCoordinates = Coordinates(latitude: 0, longitude: 0)
        
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        self.currentCoordinates.latitude = locValue.latitude
        self.currentCoordinates.longitude = locValue.longitude
    }
    
    func setUsersClosestCity(latitude: Double, longitude: Double)
    {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in

            let placeArray = placemarks as [CLPlacemark]?

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]

            // Address dictionary
            //print(placeMark.addressDictionary)

            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? NSString
            {
               // print(locationName)
            }

            // Street address
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString
            {
                //print(street)
            }

            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
            }

            // Zip code
            if let state = placeMark.addressDictionary?["State"] as? NSString
            {
                print(state)
            }

            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString
            {
                print(country)
            }
        }
    }
    
    
    
}
