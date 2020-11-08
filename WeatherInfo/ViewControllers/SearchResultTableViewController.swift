//
//  SearchResultTableViewController.swift
//  WeatherInfo
//
//  Created by Yicong Li on 7/11/20.
//

import UIKit
import MapKit

// the table view showing the search result
class SearchResultTableViewController: UITableViewController {

    /// store items that match the searching result
    var matchingItems: [MKMapItem] = []
    var mapSearchDelegate: HandleMapSearch? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.detailTextLabel?.text = item.parseAddress()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        mapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }

}

extension SearchResultTableViewController: UISearchResultsUpdating {
    
    // send request and show the result on the list
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
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
