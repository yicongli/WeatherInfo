//
//  ApiManager.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let instance = ApiManager()
    
    struct Keys {
        static let apiKey = "510be3c03e74d8facbd91929b953cb28"
        static let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    }
    
    func fetchWeatherInfo(city_ID: Int, completionHandler: @escaping ((WeatherInfoProperties) -> ())) {
        
        let param = ["id":String(city_ID), "units": "metric", "APPID": Keys.apiKey]
        fetchWeatherInfoWith(param: param, completionHandler: completionHandler)
    }
    
    
    private func fetchWeatherInfoWith(param: [String:String], completionHandler: @escaping ((WeatherInfoProperties) -> ())) {
        
        AF.request(ApiManager.Keys.baseUrl, parameters: param).validate().responseDecodable(of: WeatherInfoProperties.self) { response in
            
            guard let weatherInfo = response.value else {
                debugPrint("Error! : \(response.error.debugDescription)")
                return
            }
            
            completionHandler(weatherInfo)
        }
    }
}
