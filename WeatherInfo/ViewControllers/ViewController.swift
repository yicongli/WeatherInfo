//
//  ViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let model = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        model.fetchAllStoredCitiesInfo()
    }


}

