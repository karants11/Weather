//
//  ToggleButton.swift
//  Weather
//
//  Created by Karan T Rai on 13/06/21.
//

import UIKit

class ToggleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setToggleButtonProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setToggleButtonProperties()

    }
    
    func setToggleButtonProperties() {
        
        self.setImage(UIImage(named: "favouritedisable"), for: .normal)
        self.setImage(UIImage(named: "favouriteactive"), for: .selected)
        
        self.isSelected = false
        
        self.addTarget(self, action: #selector(toggle), for: .touchUpInside)

    }
    
    @objc func toggle() {
        
        self.isSelected = !self.isSelected
    }
}
