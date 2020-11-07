//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation

class WeatherListViewModel {
    
    struct Keys {
        static let timeInterval = 3600.0
    }
    
    /// all cites' weather info
    var cityList = [WeatherInfoProperties]()
    var selectedIndex: Int?
    var timer:Timer?
    
    var selectedCity:WeatherInfoProperties? {
        if let select = selectedIndex {
            return cityList[select]
        }
        else {
            return nil
        }
    }
    
    func fetchAllStoredCitiesInfo (completionHandler: @escaping () -> Void) {
        StorageManager.instance.getAllCitiesID { IDs in
            
            ApiManager.instance.fetchInfoWith(cityIDs: IDs) { (weatherList) in
                self.cityList = weatherList.list
                completionHandler()
            }
        }
    }
    
    func startTimer(fireOperation:@escaping (() -> ())) {
        timer = Timer.scheduledTimer(withTimeInterval: Keys.timeInterval, repeats: true) { timer in
            print("Timer fired!")
            fireOperation()
        }
    }
}
