//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

class WeatherListViewModel {
    
    /// all cites' weather info
    var cityList = [WeatherInfoProperties]()
    
    func fetchAllStoredCitiesInfo (completionHandler: @escaping () -> Void) {
        StorageManager.instance.getAllCitiesID { IDs in
            
            ApiManager.instance.fetchInfoWith(cityIDs: IDs) { (weatherList) in
                self.cityList = weatherList.list
                completionHandler()
            }
        }
    }
    
    
}
