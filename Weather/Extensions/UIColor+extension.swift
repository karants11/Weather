//
//  UIColor+extension.swift
//  Weather
//
//  Created by Karan T Rai on 10/06/21.
//

import UIKit

extension UIColor {
    
    static func backgroungColor() -> UIColor {
        if let image = UIImage(named: "background.png") {
            return UIColor(patternImage: image)
        }else {
            return UIColor.clear
        }
    }
    
    static func clearBackgroundButtonFontColor() -> UIColor {
        return UIColor.white
    }
    
    static func lableTextColor() -> UIColor {
        return UIColor.white
    }
    
    static func favCityNameTextColor() -> UIColor {
        return UIColor(red: 225/225, green: 229/225, blue: 57/225, alpha: 1)
    }
    
    static func blackTextColor() -> UIColor {
        return UIColor.black
    }
    
    static func titleBackgroundColor() -> UIColor {
        return UIColor(red: 41/225, green: 47/225, blue: 51/225, alpha: 1)
    }
}
