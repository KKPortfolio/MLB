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
        case fullName = "Name"
        case weight = "Weight"
        case dob = "Date of Birth"
    }
    
    var searchedPlayer: PlayerCodable?
    var searchTerm: String = ""

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
    
//    to return detailed information to the cell
    func playerDetail(item: String) -> String {
        var detail: String {
            switch item.lowercased() {
            case "position":
                return self.searchedPlayer?.position ?? ""
            case "name":
                return self.searchedPlayer?.fullName ?? ""
            case "weight":
                return "\(self.searchedPlayer?.weight ?? 0) lb"
            case "date of birth":
                return self.searchedPlayer?.dob ?? ""
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
        return searchedPlayer?.fullName
    }
}


