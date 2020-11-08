//
//  WindProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  Wind info

import Foundation

struct WindProperties: Decodable {
    
    let speed: Double
    let deg: Int
    
    enum CodingKeys: String, CodingKey {
        case speed         = "speed"
        case deg           = "deg"
    }
}
