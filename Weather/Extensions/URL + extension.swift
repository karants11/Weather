//
//  URL + extension.swift
//  Weather
//
//  Created by Karan T Rai on 22/06/21.
//

import Foundation

extension URL {
    static func weatherReportPath() -> URL {
        let fileManager = FileManager.default
        let folders = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentFolder = folders[0]
        let filePath = documentFolder.appendingPathComponent("weather.archive")
        return filePath
        
    }
    
    static func favouriteStorePath() -> URL {
        let fileManager = FileManager.default
        let folders = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentFolder = folders[0]
        let filePath = documentFolder.appendingPathComponent("favourite.archive")
        return filePath
        
    }
    
    static func recentSearchStorePath() -> URL {
        let fileManager = FileManager.default
        let folders = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentFolder = folders[0]
        let filePath = documentFolder.appendingPathComponent("recentSearch.archive")
        return filePath
    }
    
    static func ABC() {
        print("     ")
    }
}
