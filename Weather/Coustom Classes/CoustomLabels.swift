//
//  CoustomLabels.swift
//  Weather
//
//  Created by Karan T Rai on 15/06/21.
//

import UIKit

class CoustomLabels: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.personalizeLable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.personalizeLable()
    }
    
    func personalizeLable() {
        self.backgroundColor = .clear
        self.font = UIFont(name: "Roboto Regular", size: 14)
        self.textColor = UIColor.lableTextColor()
    }
        
}

extension CoustomLabels {
    func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}

class temperatureCoustomLable: CoustomLabels {
    override func personalizeLable() {
        self.font = UIFont(name: "Roboto Medium", size: 18)
        self.textColor = UIColor.lableTextColor()
    }
}

class cityNameCoustomLable: CoustomLabels {
    override func personalizeLable() {
        self.font = UIFont(name: "Roboto Medium", size: 15)
        self.textColor = UIColor.favCityNameTextColor()
    }
}

class blackTextLable: CoustomLabels {
    override func personalizeLable() {
        self.font = UIFont(name: "Roboto Regular", size: 14)
        self.textColor = UIColor.blackTextColor()
    }
}

class whiteTextLableFont18: CoustomLabels {
    override func personalizeLable() {
        self.font = UIFont(name: "Roboto Regular", size: 18)
        self.textColor = UIColor.white
    }
}


class tavleViewTitleLable: CoustomLabels {
    override func personalizeLable() {
        self.font = UIFont(name: "Roboto Medium", size: 20)
        self.textColor = UIColor.titleBackgroundColor()
    }
}

class dateLable: CoustomLabels {
    override func personalizeLable() {
        self.font = UIFont(name: "Roboto Regular", size: 13)
        self.textColor = UIColor.white.withAlphaComponent(0.6)
        self.addCharacterSpacing(kernValue: 1.5)
    }
}
