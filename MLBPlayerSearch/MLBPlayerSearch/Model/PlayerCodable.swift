//
//  PlayerCodable.swift
//  MLBPlayerSearch
//
//  Created by Mark Kim on 2020-05-31.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation

struct PlayerCodable: Decodable {
    let position: String?
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case searchPlayerAll = "search_player_all"
        case queryResults = "queryResults"
        case row = "row"
        case position = "position"
        case fullName = "name_display_last_first"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let searchPlayerAll = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .searchPlayerAll)
        let queryResults = try searchPlayerAll.nestedContainer(keyedBy: CodingKeys.self, forKey: .queryResults)
        let rowContainer =  try queryResults.nestedContainer(keyedBy: CodingKeys.self, forKey: .row)
        
        position = try rowContainer.decode(String.self, forKey: .position)
        fullName = try rowContainer.decode(String.self, forKey: .fullName)
    }
}
