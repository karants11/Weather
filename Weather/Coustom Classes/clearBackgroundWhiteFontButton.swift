//
//  clearBackgroundWhiteFontButton.swift
//  Weather
//
//  Created by Karan T Rai on 14/06/21.
//

import UIKit

class clearBackgroundWhiteFontButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureButton()

    }
    
    func configureButton() {
        self.backgroundColor = .clear
        self.titleLabel?.font = UIFont(name: "Roboto Medium", size: 13)
        self.setTitleColor(UIColor.clearBackgroundButtonFontColor(), for: .normal)
    }
}


