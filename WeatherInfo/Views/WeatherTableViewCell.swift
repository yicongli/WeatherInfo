//
//  WeatherTableViewCell.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  view cell for WeatherListTableViewController

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setCellValue(weatherinfo: WeatherInfoProperties) {
        cityNameLabel.text = weatherinfo.name
        temperatureLabel.text = "\(Int(weatherinfo.main.temp)) °C"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
