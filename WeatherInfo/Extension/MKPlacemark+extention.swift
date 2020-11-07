//
//  MKPlacemark+extention.swift
//  WeatherInfo
//
//  Created by Yicong Li on 7/11/20.
//

import Foundation
import MapKit

extension MKPlacemark {
    
    func parseAddress() -> String {
        let firstSpace = (subThoroughfare != nil && thoroughfare != nil) ? " " : ""
        let comma = (subThoroughfare != nil || thoroughfare != nil) && (subAdministrativeArea != nil || administrativeArea != nil) ? ", " : ""
        let secondSpace = (subAdministrativeArea != nil || administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            subThoroughfare ?? "",
            firstSpace,
            // street name
            thoroughfare ?? "",
            comma,
            // city
            locality ?? "",
            secondSpace,
            // state
            administrativeArea ?? ""
        )
        return addressLine
    }
}
