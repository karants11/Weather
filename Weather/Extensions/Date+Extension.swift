//
//  Date+Extension.swift
//  Weather
//
//  Created by Karan T Rai on 15/06/21.
//

import Foundation

extension Date
{
    static func currentDateAndTime() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE dd/MM/yyyy HH:mm"
        let dateString = df.string(from: date)
        
        return dateString
    }
}
