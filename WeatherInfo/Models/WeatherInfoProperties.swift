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
    let main: MainTempProperties
    let sys: SysInfoProperties
    let visibility: Int
    let wind: WindProperties
    let clouds: CloudsProperties
    let dt: Int
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case coord      = "coord"
        case weather    = "weather"
        case main       = "main"
        case visibility = "visibility"
        case wind       = "wind"
        case clouds     = "clouds"
        case dt         = "dt"
        case sys        = "sys"
        case id         = "id"
        case name       = "name"
    }
}
