//
//  MainTempProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

struct MainTempProperties: Decodable {
    
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp       = "temp"
        case feelsLike  = "feels_like"
        case tempMin    = "temp_min"
        case tempMax    = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}
