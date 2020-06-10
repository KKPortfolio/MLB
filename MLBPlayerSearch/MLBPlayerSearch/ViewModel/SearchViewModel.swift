//
//  ViewModel.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-05-06.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class SearchViewModel {

    enum PlayerInfo: String, CaseIterable {
        case position = "Position"
        case weight = "Weight"
        case birth_date = "Date of Birth"
        case birth_country = "Country of Birth"
        case birth_state = "State of Birth"
        case nameFirstAndLast = "Name"
        case college = "College"
        case bats = "Bats"
        case team_code = "Team Code"
        case birth_city = "Birth City"
        case height_feet = "Height (in feet)"
        case pro_debut_date = "Debut Date"
        case team_full = "Team"
        case throwing_arm = "Throwing Arm"
        case leauge = "League"
        case high_school = "High School"
        
    }
    
    var searchedPlayer: PlayerCodable?
    var searchTerm: String = ""
    var listOfSearches: [String] = []

//    Functions
    func fetchPlayer(completion: @escaping (Error?) -> ()) {
        NetworkManager.shared.execute(searchTerm: searchTerm) { data in
            do {
                let player = try JSONDecoder().decode(PlayerCodable.self, from: data)
                self.searchedPlayer = player
                completion(nil)
            } catch {
                self.searchedPlayer = nil
                completion(error)
            }
        }
    }
    
    func saveSearchHistory(){
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(listOfSearches, toFile: SearchHistory.archiveURL.path)
        if !isSucessfulSave {
            print("Failed to save search history")
        }
    }
    
    func loadSearchHistory() -> [String]?{
        guard let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: SearchHistory.archiveURL.path) as? [String] else { return nil}
        self.listOfSearches = savedData
        return NSKeyedUnarchiver.unarchiveObject(withFile: SearchHistory.archiveURL.path) as? [String]
    }
    
    func searchTermValidater() -> Bool {
        self.listOfSearches.append(self.searchTerm)
        let flag = self.searchTerm.lowercased().split(separator: " ").count
        if flag > 2 || flag < 1 {
            return false
        } else {
            return true
        }
    }
    
//    to return detailed information to the cell
    func playerDetail(item: String) -> String {
        var detail: String {
            switch item.lowercased() {
            case "position":
                return self.searchedPlayer?.position ?? ""
            case "name":
                return self.searchedPlayer?.name_display_first_last ?? ""
            case "weight":
                return "\(self.searchedPlayer?.weight ?? 0) lb"
            case "date of birth":
                return self.searchedPlayer?.birth_date ?? ""
            case "country of birth":
                return self.searchedPlayer?.birth_country ?? ""
            case "state of birth":
                return self.searchedPlayer?.birth_state ?? ""
            case "college":
                return self.searchedPlayer?.college ?? ""
            case "bats":
                return self.searchedPlayer?.bats ?? ""
            case "team code":
                return self.searchedPlayer?.team_code ?? ""
            case "birth city":
                return self.searchedPlayer?.birth_city ?? ""
            case "Height (in feet)":
                return "\(self.searchedPlayer?.height_feet ?? 0)"
            case "debut date":
                return self.searchedPlayer?.pro_debut_date ?? ""
            case "team":
                return self.searchedPlayer?.team_full ?? ""
            case "throwing arm":
                return self.searchedPlayer?.throwing_arm ?? ""
            case "leage":
                return self.searchedPlayer?.league ?? ""
            case "high school":
                return self.searchedPlayer?.high_school ?? ""
            default:
                return "No Value"
            }
        }
        return detail
    }
    
    //computed variable
    var numberOfRows: Int {
        guard self.searchedPlayer != nil else {
            return 0
        }
        return PlayerInfo.allCases.count
    }
    
    var playerName: String? {
        return searchedPlayer?.name_display_last_first
    }
}


