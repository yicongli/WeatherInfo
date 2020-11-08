//
//  Date+Extension.swift
//  WeatherInfo
//
//  Created by Yicong Li on 7/11/20.
//

import Foundation

extension Date {
    
    
    /// convert timeinterval to time str
    /// - Returns: time str, eg. 18:69
    static func numberToTimeStr(dateNumber: Int, secondsFromGMT: Int) -> String {
        
        let timeInterval = TimeInterval(dateNumber + secondsFromGMT)
        let date = Date(timeIntervalSince1970: timeInterval)
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return "\(hour):\(minutes)"
    }
}
