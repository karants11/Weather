//
//  UIImage+Extension.swift
//  Weather
//
//  Created by Karan T Rai on 15/06/21.
//

import UIKit

extension UIImage {
    static func emptyTableViewImage() -> UIImage? {
        guard let image = UIImage(named: "nothing") else {
            return nil
        }
        return image
    }
    
    static func weatherDescribing(weatherCondition: String) -> UIImage? {
        guard let image = UIImage(named: weatherCondition.lowercased()) else {
            return nil
        }
        return image
    }
}

