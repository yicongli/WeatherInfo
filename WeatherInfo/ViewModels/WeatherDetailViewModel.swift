//
//  WeatherDetailViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  The viewmodel for detail page

import Foundation

class WeatherDetailViewModel {
    
    /// current shown city info
    var cityInfo:WeatherInfoProperties? = nil
    /// the detail info of current city
    var detailInfo: [(name: String, data:String)] = []
    
    /// update shown city info
    func updateCityInfo(_ info:WeatherInfoProperties, completionHandler:@escaping (()->())){
        cityInfo = info
        detailInfo = info.infoArray()
        
        completionHandler()
    }
}

