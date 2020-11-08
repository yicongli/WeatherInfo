//
//  WeatherInfoProperties.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  Full weather info for one city

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
    
    func infoArray() -> [(name: String, data:String)] {

        var array:[(name: String, data:String)] = []
        
        array.append(("SUNRISE", Date.numberToTimeStr(dateNumber:sys.sunrise, secondsFromGMT:sys.timezone)))
        array.append(("SUNSET", Date.numberToTimeStr(dateNumber:sys.sunset, secondsFromGMT:sys.timezone)))
        array.append(("FEELS LIKE", String.doulbelToTempStr(temp:main.feelsLike)))
        array.append(("HUMIDITY", "\(main.humidity)%"))
        array.append(("PRESSURE", "\(main.pressure) hPa"))
        array.append(("VISIBILITY", "\(Double(visibility)/1000) km"))
        array.append(("WIND", "\(wind.speed) km/h"))
        array.append(("COUNTRY", sys.country))
        
        return array
    }
}
