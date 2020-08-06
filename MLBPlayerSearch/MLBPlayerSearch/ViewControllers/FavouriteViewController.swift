//
//  FavouriteViewController.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-06-20.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

//    MARK: Variables
    var searchController = UISearchController()
    var searchViewController: SearchViewController = SearchViewController(nibName: nil, bundle: nil)
    var alertMaker = ErrorAlerts()
    
    @IBOutlet weak var favouriteTableView: UITableView!
    
//    MARK: Actions
    @IBAction func deleteAllButton(_ sender: UIButton) {
        searchViewController.searchViewModel.coreDataHandler.deleteAllFavourites()
        alertMaker.makeAlertController(title: "", message: "All favourites are deleted")
        alertMaker.addAction(title: "Got It!")
        DispatchQueue.main.async {
            self.present(self.alertMaker.alertController!, animated: true)
        }
        favouriteTableView.reloadData()
    }
    //    MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupFavouriteTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFavouriteTableView()
    }
}

extension FavouriteViewController {
    func setupSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter Player Name"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Favourite Players"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    func setupFavouriteTableView(){
        searchViewController.searchViewModel.coreDataHandler.loadFavourite()
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.reloadData()
    }
}

extension FavouriteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension FavouriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return searchViewController.searchViewModel.coreDataHandler.favouritePlayer.favouritePlayers.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favourite", for: indexPath)
            cell.textLabel?.text = searchViewController.searchViewModel.coreDataHandler.favouritePlayer.favouritePlayers[indexPath.row].value(forKey: "playerName") as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deleteAll", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
