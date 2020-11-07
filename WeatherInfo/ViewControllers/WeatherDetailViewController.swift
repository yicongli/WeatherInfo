//
//  WeatherDetailViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherConLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lowHighTempLabel: UILabel!
    
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    let model = WeatherDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLabels()
    }
    
    func setLabels() {
        guard let info = model.cityInfo else {
            debugPrint("no city info")
            return
        }
        
        cityNameLabel.text = info.name
        weatherConLabel.text = info.weather.first?.description
        currentTempLabel.text = String.doulbelToTempStr(temp: info.main.temp)
        lowHighTempLabel.text = "L:\(String.doulbelToTempStr(temp: info.main.tempMin)) H:\(String.doulbelToTempStr(temp: info.main.tempMax))"

        sunRiseLabel.text = Date.numberToTimeStr(dateNumber: info.sys.sunrise, secondsFromGMT: info.sys.timezone)
        sunSetLabel.text = Date.numberToTimeStr(dateNumber: info.sys.sunset, secondsFromGMT: info.sys.timezone)
        feelsLikeLabel.text = String.doulbelToTempStr(temp: info.main.feelsLike)
        humidityLabel.text = "\(info.main.humidity)%"
        pressureLabel.text = "\(info.main.pressure) hPa"
        visibilityLabel.text = "\(Double(info.visibility)/1000) km"
        windLabel.text = "\(info.wind.speed) km/h"
        countryLabel.text = info.sys.country
    }
}
