//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

class WeatherListViewModel {
    
    /// all cites' weather info
    var orders = [WeatherInfoProperties]()
    
    func fetchAllStoredCitiesInfo () {
        ApiManager.instance.fetchInfoWith(cityIDs: [4163971, 2147714, 2174003]) { (weatherList) in
            print(weatherList)
        }
    }
}
