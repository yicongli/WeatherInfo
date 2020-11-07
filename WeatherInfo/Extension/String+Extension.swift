//
//  String+Extension.swift
//  WeatherInfo
//
//  Created by Yicong Li on 7/11/20.
//

import Foundation

extension String {
    
    static func doulbelToTempStr(temp: Double) -> String{
        return "\(Int(temp))°"
    }
}
