//
//  CoustomView.swift
//  Weather
//
//  Created by Karan T Rai on 22/06/21.
//

import UIKit

class CoustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.personalizeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.personalizeView()
    }
    
    func personalizeView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
}
