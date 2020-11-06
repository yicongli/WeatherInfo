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
        StorageManager.instance.getAllCitiesID { IDs in
            ApiManager.instance.fetchInfoWith(cityIDs: IDs) { (weatherList) in
                print(weatherList)
            }
        }
        
        
    }
}
