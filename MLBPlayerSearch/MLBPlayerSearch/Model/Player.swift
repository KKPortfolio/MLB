//
//  Player.swift
//  MLBPlayerSearch
//
//  Created by King Kurt on 2020-05-06.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation

struct PlayerLists: Decodable {
    let data: TopData
    
    struct TopData: Decodable {
        let players: [Children]
        enum CodingKeys: String, CodingKey {
            case players = "children"
        }
        
        struct Children: Decodable {
            let player: Player
            enum CodingKeys: String, CodingKey {
                case player = "data"
            }
        }
    }
    
    var players: [Player] {
        return data.players.map { $0.player }
    }
}

struct Player: Decodable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}


