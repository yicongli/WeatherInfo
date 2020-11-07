//
//  WeatherSearchViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation
import MapKit


class WeatherSearchViewModel:NSObject {
    
    weak var delegate: CitySearchViewController? = nil
    
    let locationManager = CLLocationManager()
    var selectedPin:MKPlacemark? = nil
    var currentUserLocation: CLLocation? = nil
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension WeatherSearchViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if (currentUserLocation == nil) {
                currentUserLocation = location
                let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                delegate?.mapView.setRegion(region, animated: false)
                print("location: \(location)")
                
                delegate?.setAnnotationWithLocation(location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
