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
    var resultSearchController:UISearchController? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        model.setupLocationManager()
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(mytapGestureRecognizer)
        
    }
    
    // MARK: - Actions
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
        resultDelegate?.didSelectCity(placemark: model.selectedPin!)
    }
    
    @IBAction func backToCurrentLocation(_ sender: Any) {
        guard let location = model.currentUserLocation else {
            return
        }
        
        setAnnotationWithLocation(location)
    }
    
    // MARK: - set objects
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
        model.selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        //annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.title = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

}

extension CitySearchViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        setAnnotationWithPlaceMark(placemark)
    }
}
