//
//  ShortCityInfo.swift
//  WeatherInfo
//
//  Created by Yicong Li on 7/11/20.
//

import Foundation

struct ShortCityInfo: Decodable {
    
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case name       = "name"
    }
}
