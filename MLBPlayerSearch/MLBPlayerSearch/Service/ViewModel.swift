//
//  ViewModel.swift
//  MLBPlayerSearch
//
//  Created by King Kurt on 2020-05-06.
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

    func fetchPlayer(completion: @escaping (Error?) -> ()) {
        NetworkManager.shared.execute(searchTerm: searchTerm) { data in
            do {
                let player = try JSONDecoder().decode(PlayerCodable.self, from: data)
                self.searchedPlayer = player
                completion(nil)
            } catch {
//                self.searchedPlayer = nil
                completion(error)
            }
        }
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

