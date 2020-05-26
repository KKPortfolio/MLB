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
    var searchTerm: String = ""
    var isSearched: Bool = false
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
    
    func setupNoResultsView(searchTerm: String){
        emptyLabel.text = "No Results for \"\(searchTerm)\""
        emptyViewAppears()
    }
    
    func setupEmptyView(){
        emptyLabel.text = "Enter Player Name"
        emptyViewAppears()
    }
    
    func filterWords(searchTerm: String){
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

    func restoreData(){
        dataUpdated = dataOriginal
        tableView.reloadData()
    }
    
    func fetchingPlayers(searchTerm: String){
        NetworkManager.shared.execute(searchTerm: searchTerm) { (result: Data) in
            ViewModel.JSONParsing(rawData: result) { (playerObject: Player) in
                print(playerObject.birth_city!)
            }
        }
    }
}

//MARK: extensions
extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
        searchController.isActive = true
        searchBar.text = searchTerm
        fetchingPlayers(searchTerm: searchTerm)
        filterWords(searchTerm: searchTerm)
        if isSearched {
            tableViewAppears()
        } else {
            setupNoResultsView(searchTerm: searchTerm)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        restoreData()
        setupEmptyView()
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
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
