//
//  ViewController.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-04-21.
//  Copyright © 2020 KK. All rights reserved.
//




import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUpdated.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataUpdated[indexPath.row]
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterWords(searchTerm: searchText)
        } else {
            restoreData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterWords(searchTerm: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        restoreData()
        
    }
    
    
    var searchController: UISearchController!
    var dataOriginal: [String] = ["Trout", "Betts", "Ryu", "Sam", "Edwin", "Acuna", "Yellich"]
    var dataUpdated: [String] = ["No Results"]
    
    
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

        dataUpdated = dataOriginal
        tableView.reloadData()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false

        //        puts search bar inside container
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
    }
    
    
//    MARK: filters results with search text
    func filterWords(searchTerm: String){
        
        if searchTerm.count > 0 {
            dataUpdated = dataOriginal
            let filteredResults = dataUpdated.filter { $0.lowercased().contains(searchTerm.lowercased())}
            
            if filteredResults.count < 1 {
                dataUpdated.removeAll()
                dataUpdated.append("No Results for \(searchTerm)")
                tableView.reloadData()
            } else {
            
                dataUpdated = filteredResults
                tableView.reloadData()
            }
        }
//        } else {
//            dataUpdated = dataOriginal
//            tableView.reloadData()
//        }
    }
    
//    MARK: restores data to default
    func restoreData(){
        dataUpdated = dataOriginal
        tableView.reloadData()
    }
}
