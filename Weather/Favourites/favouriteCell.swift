//
//  favouriteCell.swift
//  Weather
//
//  Created by Karan T Rai on 14/06/21.
//

import UIKit

class favouriteCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var currentTemperature: UILabel!
    
    @IBOutlet weak var weatherCondition: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var favButton: ToggleButton!
}
