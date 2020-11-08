//
//  WeatherSearchViewModel.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//
//  The viewmodel for search city

import Foundation
import MapKit


class WeatherSearchViewModel:NSObject {
    
    /// corelated view controller
    weak var delegate: CitySearchViewController? = nil
    /// location manager
    let locationManager = CLLocationManager()
    /// current selected position
    var selectedPin:MKPlacemark? = nil
    /// the current location of the device
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
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // get user location only the first time when starting the application
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
