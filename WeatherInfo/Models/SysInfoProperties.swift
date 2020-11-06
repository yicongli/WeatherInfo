//
//  SysInfoProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

struct SysInfoProperties: Decodable {
    
    let timezone: Int
    let country: String
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case timezone   = "timezone"
        case country    = "country"
        case sunrise    = "sunrise"
        case sunset     = "sunset"
    }
}
