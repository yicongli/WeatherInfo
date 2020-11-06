//
//  ViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ApiManager.instance.fetchWeatherInfo(city_ID: 2147714) {
        ApiManager.instance.fetchWeatherInfo(city_ID: 2147714) { weatherInfo in
            print(weatherInfo)
        }
            
        // Do any additional setup after loading the view.
    }


}

