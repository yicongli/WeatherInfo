//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  The viewmodel for Showing all city wheater

import Foundation
import MapKit

class WeatherListViewModel {
    
    struct Keys {
        /// update weather every hour
        static let timeInterval = 3600.0
    }
    
    /// all cites' weather info
    var cityList = [WeatherInfoProperties]()
    /// current selected city index
    var selectedIndex: Int?
    /// timer for updating
    var timer:Timer?
    /// computed variable, return current selected city info
    var selectedCity:WeatherInfoProperties? {
        if let select = selectedIndex {
            return cityList[select]
        }
        else {
            return nil
        }
    }
    
    /// get all local city IDs
    func fetchAllStoredCitiesInfo (completionHandler: @escaping () -> Void) {
        StorageManager.instance.getAllCitiesID { IDs in
            
            ApiManager.instance.fetchInfoWith(cityIDs: IDs) { (weatherList) in
                self.cityList = weatherList.list
                completionHandler()
            }
        }
    }
    
    /// get current selected city info from server
    func fetchSelectedCityInfo (placemark: MKPlacemark,completionHandler: @escaping () -> Void) {
        var cityIDs = cityList.map{$0.id}
        ApiManager.instance.fetchSingleCityInfoWith(placemark: placemark) { (cityInfo) in
            cityIDs.append(cityInfo.id)
            ApiManager.instance.fetchInfoWith(cityIDs: cityIDs) { (weatherList) in
                self.cityList = weatherList.list
                StorageManager.instance.storeAllCitiesID(cityIDs: cityIDs)
                completionHandler()
            }
        }
    }
    
    /// timer for periodically update
    func startTimer(fireOperation:@escaping (() -> ())) {
        timer = Timer.scheduledTimer(withTimeInterval: Keys.timeInterval, repeats: true) { timer in
            print("Timer fired!")
            fireOperation()
        }
    }
}
