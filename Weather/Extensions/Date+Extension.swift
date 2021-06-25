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
        df.dateFormat = "E, d MMM yyy h:mm a"//"EEEE dd/MM/yyyy HH:mm"
        let dateString = df.string(from: date)
        
        return dateString.uppercased()
    }
    
    var millisecondsSince1970: Int64 {
        print((self.timeIntervalSince1970 * 1000.0).rounded())
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
