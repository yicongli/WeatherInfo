//
//  CitySearchViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark)
}

class CitySearchViewController: UIViewController, UIGestureRecognizerDelegate {

    let model = WeatherSearchViewModel()
    var resultDelegate: HandleCitySelection? = nil
    
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var currentUserLocation: CLLocation? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupLocationManager()
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(mytapGestureRecognizer)
        
    }
    
    @objc func myTapAction(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        setAnnotationWithLocation(loc)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true) {}
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        self.dismiss(animated: true) {}
        resultDelegate?.didSelectCity(placemark: selectedPin!)
    }
    
    @IBAction func backToCurrentLocation(_ sender: Any) {
        guard let location = currentUserLocation else {
            return
        }
        
        setAnnotationWithLocation(location)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupSearchBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewController(
            withIdentifier: String(describing: "SearchResultTableViewController")) as! SearchResultTableViewController
        resultVC.mapView = mapView
        resultVC.mapSearchDelegate = self
        
        resultSearchController = UISearchController(searchResultsController: resultVC)
        resultSearchController?.searchResultsUpdater = resultVC
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    func setAnnotationWithLocation(_ location:CLLocation){
        // Look up the location and pass it to the completion handler
        CLGeocoder().reverseGeocodeLocation(location,
                    completionHandler: {[weak self] (placemarks, error) in
            if error == nil {
                let placemark = MKPlacemark(placemark: (placemarks?[0])!)
                self?.setAnnotationWithPlaceMark(placemark)
            }
        })
    }
    
    func setAnnotationWithPlaceMark(_ placemark:MKPlacemark) {
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        //annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.title = " \(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

}

extension CitySearchViewController: CLLocationManagerDelegate {
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
                mapView.setRegion(region, animated: false)
                print("location: \(location)")
                
                setAnnotationWithLocation(location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

extension CitySearchViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        setAnnotationWithPlaceMark(placemark)
    }
}
