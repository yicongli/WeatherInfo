//
//  WeatherProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  weather condition info for the specific place

import Foundation

struct WeatherProperties: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    
    enum CodingKeys: String, CodingKey {
        case id             = "id"
        case main           = "main"
        case description    = "description"
        case icon           = "icon"
    }
}
