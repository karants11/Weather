//
//  Int+Extension.swift
//  Weather
//
//  Created by Karan T Rai on 22/06/21.
//

import Foundation

extension Int {
    
    static func getDateDiff(start: Date, end: Date) -> Int  {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: start, to: end)

        let seconds = dateComponents.second
        return Int(seconds!)
    }
}
