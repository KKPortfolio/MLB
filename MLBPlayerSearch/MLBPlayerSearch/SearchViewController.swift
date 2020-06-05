//
//  ViewController.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-04-21.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
//    MARK: Variables
    var searchController: UISearchController!
    var dataOriginal: [String] = []
    var dataUpdated: [String] = ["No Results"]
    var isSearched: Bool = false
    var searchViewModel = SearchViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyView()
        setupTableView()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupEmptyView()
    }
    
//    MARK: Functions
    func emptyViewAppears(){
        emptyView.isHidden = false
        tableView.isHidden = true
    }
    
    func tableViewAppears(){
        emptyView.isHidden = true
        tableView.isHidden = false
    }
    
    func setupNoResultsView(){
        emptyLabel.text = "No Results for \"\(searchViewModel.searchTerm)\""
        emptyViewAppears()
    }
    
    func setupEmptyView(){
        emptyLabel.text = "Enter Player Name"
        emptyViewAppears()
    }
    
    func filterWords(){
        //temporarily forcing it to true to see if fetching data from API works
        //        dataUpdated = dataOriginal
        //        let filteredResults = dataUpdated.filter { $0.lowercased().contains(searchTerm.lowercased())}
        //        if filteredResults.count > 0 {
        //            dataUpdated = filteredResults
        //            tableView.reloadData()
        //            isSearched = true
        //        } else {
        //            isSearched = false
        //        }
        isSearched = true
    }

//    func restoreData(){
//        dataUpdated = dataOriginal
//        tableView.reloadData()
//    }
    
    func fetchingPlayers() {
        self.searchViewModel.fetchPlayer { [weak self] error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true)
                    //setupNoResultsView
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: extensions
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.searchTerm = searchBar.text ?? ""
        searchController.isActive = true
        searchBar.text = searchViewModel.searchTerm
        fetchingPlayers()
        filterWords()
        if isSearched {
            tableViewAppears()
        } else {
            setupNoResultsView()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
//        restoreData()
        setupEmptyView()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = SearchViewModel.PlayerInfo.allCases[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = row.rawValue
        cell.detailTextLabel?.text = searchViewModel.playerDetail(item: row.rawValue)
        return cell
    }
}

extension SearchViewController {
    //    MARK: UISetup
    func setupTableView(){
//        tableView.delegate = self
        tableView.dataSource = self
//        dataUpdated = dataOriginal
        tableView.reloadData()
    }
    
    func setupSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
