//
//  WeatherListTableViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import UIKit
import SnapKit
import MapKit

protocol HandleCitySelection {
    
    func didSelectCity(placemark: MKPlacemark)
}

class WeatherListTableViewController: UITableViewController {

    let model = WeatherListViewModel()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.startTimer { [weak self] in
            self?.fetchAllCityInfo()
            
            if let vc = self?.navigationController?.topViewController as? WeatherDetailViewController,
               let city = self?.model.selectedCity{
                vc.model.updateCityInfo(city) {
                    vc.setLabels()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if spinner.superview == nil, let superView = tableView.superview {
            superView.addSubview(spinner)
            superView.bringSubviewToFront(spinner)
            spinner.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
            }
        }
        
        fetchAllCityInfo()
    }
    
    @IBAction func showSearchVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(
            withIdentifier: String(describing: "CitySearchNavVC")) as! UINavigationController
        let vc = nav.topViewController as! CitySearchViewController
        vc.resultDelegate = self
        
        nav.modalPresentationStyle = .overCurrentContext
        self.present(nav, animated: true) {}
    }
    
    func showDetailsVC(selectedInfo: WeatherInfoProperties) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: String(describing: WeatherDetailViewController.self)) as! WeatherDetailViewController
        
        vc.model.updateCityInfo(selectedInfo) {}
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchAllCityInfo() {
        spinner.startAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        model.fetchAllStoredCitiesInfo { [weak self] in
            self?.tableView.reloadData()
            self?.spinner.stopAnimating()
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

// MARK: - Table view data source
extension WeatherListTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cityList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            
            print("dequeueReusableCell doesn't return cell")
            return WeatherTableViewCell()
        }

        cell.setCellValue(weatherinfo: model.cityList[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did selet row at: \(indexPath.row)")
    
        model.selectedIndex = indexPath.row
        showDetailsVC(selectedInfo: model.selectedCity!)
    }
}

extension WeatherListTableViewController: HandleCitySelection {
    
    func didSelectCity(placemark: MKPlacemark) {
        spinner.startAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        model.fetchSelectedCityInfo(placemark: placemark) { [weak self] in
            self?.tableView.reloadData()
            self?.spinner.stopAnimating()
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    

}
