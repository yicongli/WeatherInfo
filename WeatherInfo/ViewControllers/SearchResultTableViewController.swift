//
//  SearchResultTableViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 7/11/20.
//

import UIKit
import MapKit

class SearchResultTableViewController: UITableViewController {

    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    var mapSearchDelegate: HandleMapSearch? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func parseAddress(item:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (item.subThoroughfare != nil && item.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (item.subThoroughfare != nil || item.thoroughfare != nil) && (item.subAdministrativeArea != nil || item.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (item.subAdministrativeArea != nil || item.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            item.subThoroughfare ?? "",
            firstSpace,
            // street name
            item.thoroughfare ?? "",
            comma,
            // city
            item.locality ?? "",
            secondSpace,
            // state
            item.administrativeArea ?? ""
        )
        return addressLine
    }
}

extension SearchResultTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        let item = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = parseAddress(item: item)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        mapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }

}

extension SearchResultTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
