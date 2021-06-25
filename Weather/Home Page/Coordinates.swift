//
//  Coordinates.swift
//  Weather
//
//  Created by Karan T Rai on 13/06/21.
//

import Foundation

class Coordinates: NSObject, NSCoding {

    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.latitude, forKey: "latitude")
        coder.encode(self.longitude, forKey: "longitude")
    }
    
    required init?(coder: NSCoder) {
        guard let latitude = coder.decodeDouble(forKey: "latitude") as? Double,
              let longitude = coder.decodeDouble(forKey: "longitude") as? Double
        else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
        
    }
    

}
