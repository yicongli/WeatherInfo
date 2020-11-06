//
//  WeatherDetailViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

class WeatherDetailViewModel {
    
    var cityInfo:WeatherInfoProperties? = nil
    
    func updateCityInfo(_ info:WeatherInfoProperties){
        cityInfo = info
    }
}

