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
    @IBOutlet weak var tableView: UITableView!
    
    let model = WeatherDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setContents()
    }
    
    func setContents() {
        guard let info = model.cityInfo else {
            debugPrint("no city info")
            return
        }
        
        cityNameLabel.text = info.name
        weatherConLabel.text = info.weather.first?.description
        currentTempLabel.text = String.doulbelToTempStr(temp: info.main.temp)
        lowHighTempLabel.text = "L:\(String.doulbelToTempStr(temp: info.main.tempMin)) H:\(String.doulbelToTempStr(temp: info.main.tempMax))"

        tableView.reloadData()
    }
}

extension WeatherDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.detailInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        let item = model.detailInfo[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.data

        return cell
    }
    
}
