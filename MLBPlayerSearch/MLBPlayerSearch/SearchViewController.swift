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
    
    @IBOutlet weak var playerDetailView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var recentView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        searchHistory.listOfSearches = searchViewModel.loadSearchHistory()?.suffix(5)
        if searchHistory.listOfSearches == nil {
            setupEmptyView()
            emptyViewAppears()
        } else {
            setupRecentView()
            recentViewAppears()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchHistory.listOfSearches = searchViewModel.loadSearchHistory()?.suffix(5)
        if searchHistory.listOfSearches == nil {
            setupEmptyView()
            emptyViewAppears()
        } else {
            setupRecentView()
            recentViewAppears()
        }
    }
    
//    MARK: Functions
    func emptyViewAppears(){
        emptyView.isHidden = false
        playerDetailView.isHidden = true
        recentView.isHidden = true
    }
    
    func tableViewAppears(){
        emptyView.isHidden = true
        playerDetailView.isHidden = false
        recentView.isHidden = true
    }
    
    func recentViewAppears(){
        emptyView.isHidden = true
        playerDetailView.isHidden = true
        recentView.isHidden = false
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
                self?.playerDetailView.reloadData()
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
                setupTableView()
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
        searchViewModel.saveSearchHistory()
        searchHistory.listOfSearches = searchViewModel.loadSearchHistory()?.suffix(5)
        setupRecentView()
        recentViewAppears()
    }
}

// MARK: UITableView
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.playerDetailView {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.playerDetailView {
            return searchViewModel.numberOfRows
        } else {
            if searchHistory.listOfSearches == nil {
                return 0
            } else {
                let numberOfRowsForSection: [Int] = [1, searchHistory.listOfSearches!.count]
                var numberOfRows: Int = 0
                if section < numberOfRowsForSection.count {
                    numberOfRows = numberOfRowsForSection[section]
                }
                return numberOfRows
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.playerDetailView {
            let row = SearchViewModel.PlayerInfo.allCases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
            cell.textLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            cell.textLabel?.text = row.rawValue
            cell.detailTextLabel?.text = "\(searchViewModel.playerDetail(item: row.rawValue))"
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
        if tableView == playerDetailView {
            self.playerDetailView.deselectRow(at: indexPath, animated: true)
        } else if tableView == recentView {
            self.recentView.deselectRow(at: indexPath, animated: true)
            searchController.isActive = true
            guard let searchTerm = recentView.cellForRow(at: indexPath)?.textLabel?.text else { return }
            searchViewModel.searchTerm = searchTerm
            fetchingPlayers()
            setupTableView()
            tableViewAppears()
        }
    }
}

extension SearchViewController {
    //    MARK: UISetup
    func setupTableView(){
        playerDetailView.delegate = self
        playerDetailView.dataSource = self
        playerDetailView.reloadData()
    }
    
    func setupRecentView(){
        recentView.delegate = self
        recentView.dataSource = self
        recentView.reloadData()
    }
    
    func setupNoResultsView(){
        self.emptyLabel.text = "No Results for \"\(self.searchViewModel.searchTerm)\""
        self.emptyViewAppears()
    }
    
    func setupEmptyView(){
        emptyLabel.text = "Search the Player"
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
