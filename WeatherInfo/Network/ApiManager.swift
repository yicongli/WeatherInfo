//
//  ApiManager.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation
import Alamofire
import MapKit

class ApiManager {
    
    static let instance = ApiManager()
    
    struct Keys {
        static let apiKey = "510be3c03e74d8facbd91929b953cb28"
        static let oneCityUrl = "https://api.openweathermap.org/data/2.5/weather"
        static let multipleCitiesUrl = "https://api.openweathermap.org/data/2.5/group"
        
    }
    
    func fetchSingleCityInfoWith(placemark: MKPlacemark,
                       completionHandler: @escaping ((ShortCityInfo) -> ())) {
        let city = placemark.locality ?? ""
        let state = placemark.administrativeArea ?? ""
        let country = placemark.countryCode ?? ""
        
        let param = ["q":"\(city),\(state),\(country)", "units": "metric", "APPID": Keys.apiKey]
        
        AF.request(Keys.oneCityUrl, parameters: param)
            .validate()
            .responseDecodable(of: ShortCityInfo.self) { response in
            
            guard let cityInfo = response.value else {
                debugPrint("Error! : \(response.error.debugDescription)")
                return
            }
            
            completionHandler(cityInfo)
        }
    }
    
    func fetchInfoWith(cityIDs: [Int], completionHandler: @escaping ((WeatherListProperties) -> ())) {
        
        let idStr = cityIDs.map(String.init).joined(separator: ",")
        let param = ["id":idStr, "units": "metric", "APPID": Keys.apiKey]
        fetchMultipleWeatherInfoWith(param: param, completionHandler: completionHandler)
    }
    
    private func fetchMultipleWeatherInfoWith(param: [String:String],
                                      completionHandler: @escaping ((WeatherListProperties) -> ())) {
        
        AF.request(Keys.multipleCitiesUrl, parameters: param)
            .validate()
            .responseDecodable(of: WeatherListProperties.self) { response in
            
            guard let weatherInfo = response.value else {
                debugPrint("Error! : \(response.error.debugDescription)")
                return
            }
            
            completionHandler(weatherInfo)
        }
    }
}
