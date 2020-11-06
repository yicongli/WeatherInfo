//
//  WeatherListProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

struct WeatherListProperties: Decodable {
    
    let cnt: Int
    let list: [WeatherInfoProperties]
    
    enum CodingKeys: String, CodingKey {
        case cnt     = "cnt"
        case list    = "list"
    }
}
