//
//  WeatherDetailViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

class WeatherDetailViewModel {
    
    var cityInfo:WeatherInfoProperties? = nil
    var detailInfo: [(name: String, data:String)] = []
    
    func updateCityInfo(_ info:WeatherInfoProperties, completionHandler:@escaping (()->())){
        cityInfo = info
        detailInfo = info.infoArray()
        
        completionHandler()
    }
}

