//
//  CordinateProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation


struct CoordinateProperties: Decodable {
    
    let lon: Double
    let lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
}
