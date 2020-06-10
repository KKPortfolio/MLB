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
    var isSearched: Bool = false
    var searchViewModel = SearchViewModel()
    var searchHistory = SearchHistory()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var recentView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        setupRecentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchHistory.listOfSearches = searchViewModel.loadSearchHistory()
        setupRecentView()
        print(searchHistory.listOfSearches!)
    }
    
//    MARK: Functions
    func emptyViewAppears(){
        emptyView.isHidden = false
        tableView.isHidden = true
        recentView.isHidden = true
    }
    
    func tableViewAppears(){
        emptyView.isHidden = true
        tableView.isHidden = false
        recentView.isHidden = true
    }
    
    func recentViewAppears(){
        emptyView.isHidden = true
        tableView.isHidden = true
        recentView.isHidden = false
    }
    
    func setupNoResultsView(){
        self.emptyLabel.text = "No Results for \"\(self.searchViewModel.searchTerm)\""
        self.emptyViewAppears()
    }
    
    func setupEmptyView(){
        emptyLabel.text = ""
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
    
    func fetchingPlayers() {
        self.searchViewModel.fetchPlayer { [weak self] error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Got it!", style: .default, handler: { (action: UIAlertAction! ) in
//                    to do something when button is pressed
                }))
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true)
                    self?.setupNoResultsView()
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
        searchViewModel.searchTerm = searchBar.text?.lowercased() ?? ""
        if searchViewModel.searchTermValidater() {
            searchController.isActive = true
            searchBar.text = searchViewModel.searchTerm
            fetchingPlayers()
            filterWords()
            if isSearched {
                tableViewAppears()
            } else {
                setupNoResultsView()
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Enter first and last name \n or last name only", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Got It!", style: .default, handler: { (action: UIAlertAction!) in
            }))
            DispatchQueue.main.async {
                self.present(alertController, animated: true)
                self.setupNoResultsView()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        searchHistory.listOfSearches = searchViewModel.loadSearchHistory()
        setupRecentView()
    }
}

// MARK: UITableView
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return searchViewModel.numberOfRows
        } else {
            let numberOfRowsForSection: [Int] = [1, searchHistory.listOfSearches!.count]
            var numberOfRows: Int = 0
            if section < numberOfRowsForSection.count {
                numberOfRows = numberOfRowsForSection[section]
            }
            return numberOfRows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let row = SearchViewModel.PlayerInfo.allCases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = row.rawValue
            cell.detailTextLabel?.text = searchViewModel.playerDetail(item: row.rawValue)
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Recent", for: indexPath)
                cell.textLabel?.text = "Recent Searches"
                cell.textLabel?.font = UIFont (name: "Helvetica-Bold", size: 24)
                cell.detailTextLabel?.text = ""
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Recent", for: indexPath)
                cell.textLabel?.text = searchHistory.listOfSearches![indexPath.row]
                cell.detailTextLabel?.text = ""
                return cell
            }
            
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController {
    //    MARK: UISetup
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func setupRecentView(){
        recentView.delegate = self
        recentView.dataSource = self
        recentView.reloadData()
        recentViewAppears()
    }
    
    func setupSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter Player Name"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "MLB Players"
    }
}
