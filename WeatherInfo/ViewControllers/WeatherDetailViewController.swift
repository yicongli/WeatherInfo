//
//  WeatherDetailViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import UIKit
import Kingfisher

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherConLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lowHighTempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let model = WeatherDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // detail list doesn't allow selection
        tableView.allowsSelection = false
        setContents()
        setImageView()
    }
    
    // show all info in the VC
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
    
    // set imangeView for weather icon
    func setImageView () {
        guard let info = model.cityInfo, let icon = info.weather.first?.icon else {
            debugPrint("no image info")
            return
        }
        
        let url = URL(string: ApiManager.Keys.imageUrl + icon + "@2x.png")

        weatherImage.kf.indicatorType = .activity
        weatherImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "DefaultImage"),
            options: [
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ], completionHandler: 
                {
                    // get the loading result
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                })
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
