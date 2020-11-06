//
//  WeatherInfoProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

struct WeatherInfoProperties: Decodable {
    
    let coord: CoordinateProperties
    let weather: [WeatherProperties]
    let base: String
    let main: MainTempProperties
    let visibility: Int
    let wind: WindProperties
    let clouds: CloudsProperties
    let dt: Int
    let sys: SysInfoProperties
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coord      = "coord"
        case weather    = "weather"
        case base       = "base"
        case main       = "main"
        case visibility = "visibility"
        case wind       = "wind"
        case clouds     = "clouds"
        case dt         = "dt"
        case sys        = "sys"
        case timezone   = "timezone"
        case id         = "id"
        case name       = "name"
        case cod        = "cod"
    }
    
}
