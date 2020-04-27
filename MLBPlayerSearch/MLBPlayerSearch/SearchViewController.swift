//
//  ViewController.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-04-21.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchController: UISearchController!
    var dataOriginal: [String] = ["Trout", "Betts", "Ryu", "Sam", "Edwin", "Acuna", "Yellich"]
    var dataUpdated: [String] = ["No Results"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyView()
        setupTableView()
        setupSearchController()
    }
    
    func setupEmptyView(){
        emptyLabel.text = "Enter Player Name"
        emptyView.isHidden = false
        tableView.isHidden = true
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

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterWords(searchTerm: searchText)
        } else {
            restoreData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate{
    
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
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUpdated.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataUpdated[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    
}

extension SearchViewController {
    //    MARK: UISetup
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        dataUpdated = dataOriginal
        tableView.reloadData()
    }
    
    func setupSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        //        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
