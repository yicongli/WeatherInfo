//
//  CloudProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  cloud condition info

import Foundation

struct CloudsProperties: Decodable {
    
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all         = "all"
    }
}
