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
    var alertMaker = ErrorAlerts()
    var favouriteButton = CustomFavouriteButton()
    
    @IBOutlet weak var playerDetailView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var recentView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: Actions
//    MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEssentials()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear \(favouriteButton.isFavourite)")
        searchController.isActive = false
        searchViewModel.saveSearchHistory()
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
            print("search button clicked \(favouriteButton.isFavourite)")
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
        print("cancel button clicked \(favouriteButton.isFavourite)")
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
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.playerDetailView {
            if section == 0 {
                return searchViewModel.numberOfRows
            } else {
                return 1
            }
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
//        MARK: Player Detail Table View
        if tableView == self.playerDetailView {
            if indexPath.section == 0 {
                let row = SearchViewModel.PlayerInfo.allCases[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
                cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                cell.textLabel?.text = row.rawValue
                cell.detailTextLabel?.text = "\(searchViewModel.playerDetail(item: row.rawValue))"
                return cell
//        MARK: Favourite Button
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Favourite", for: indexPath)
                cell.selectionStyle = .none
                favouriteButton.isFavourite = searchViewModel.coreDataHandler.isItFavourite()
                if favouriteButton.isFavourite{
                    favouriteButton.isOn = true
                    favouriteButton.fillHeart()
                    cell.contentView.addSubview(favouriteButton)
                } else {
                    favouriteButton.emptyHeart()
                    cell.contentView.addSubview(favouriteButton)
                }
                return cell
            }
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Recent", for: indexPath)
                cell.textLabel?.text = "Recent Searches"
                cell.textLabel?.font = UIFont (name: "Helvetica-Bold", size: 24)
                cell.detailTextLabel?.text = ""
                return cell
//         MARK: Recent Search Players
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
//            MARK: when recent player table cell is clicked
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
    func loadEssentials(){
        searchViewModel.coreDataHandler.loadFavourite()
//        MARK: to check if core data is properly loaded
        if searchViewModel.coreDataHandler.favouritePlayer.favouritePlayers.count != 0{
            for i in 0...searchViewModel.coreDataHandler.favouritePlayer.favouritePlayers.count-1{
                print("\(searchViewModel.coreDataHandler.favouritePlayer.favouritePlayers[i].value(forKey: "playerName")!), \(searchViewModel.coreDataHandler.favouritePlayer.favouritePlayers[i].value(forKey: "playerID")!)")
            }
        }
        searchHistory.listOfSearches = searchViewModel.loadSearchHistory()?.suffix(5)
        if searchHistory.listOfSearches == nil {
            setupEmptyView()
            emptyViewAppears()
        } else {
            setupRecentView()
            recentViewAppears()
        }
    }
    
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
    
    func setupTabBar(){
        let tabBarHeight: CGFloat = 100
        self.tabBarController?.tabBar.frame.size.height = tabBarHeight
    }
}


