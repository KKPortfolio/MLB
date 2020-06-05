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
    let name_display_last_first: String?
    let weight: Double?
    let birth_date: String?
    let birth_country: String?
    let birth_state: String?
    let name_display_first_last: String?
    let college: String?
    let height_inches: Double?
    let name_display_roster: String?
    let sport_code: String?
    let bats: String?
    let name_first: String?
    let team_code: String?
    let birth_city: String?
    let height_feet: Double?
    let pro_debut_date: String?
    let team_full: String?
    let team_abbrev: String?
    let throwing_arm: String?
    let league: String?
    let position_id: Int?
    let high_school: String?
    let name_use: String?
    let player_id: Int?
    let name_last: String?
    let team_id: Int?
    let service_years: Int?
    let active_sw: String?
    
    enum CodingKeys: String, CodingKey {
        case searchPlayerAll = "search_player_all"
        case queryResults = "queryResults"
        case row = "row"
        case position = "position"
        case name_display_last_first = "name_display_last_first"
        case weight = "weight"
        case birth_date = "birth_date"
        case birth_country = "birth_country"
        case birth_state = "birth_state"
        case name_display_first_last = "name_display_first_last"
        case college = "college"
        case height_inches = "height_inches"
        case name_display_roster = "name_display_roster"
        case sport_code = "sport_code"
        case bats = "bats"
        case name_first = "name_first"
        case team_code = "team_code"
        case birth_city = "birth_city"
        case height_feet = "height_feet"
        case pro_debut_date = "pro_debut_date"
        case team_full = "team_full"
        case team_abbrev = "team_abbrev"
        case throwing_arm = "throws"
        case league = "league"
        case position_id = "position_id"
        case high_school = "high_school"
        case name_use = "name_use"
        case player_id = "player_id"
        case name_last = "name_last"
        case team_id = "team_id"
        case service_years = "service_years"
        case active_sw = "active_sw"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let searchPlayerAll = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .searchPlayerAll)
        let queryResults = try searchPlayerAll.nestedContainer(keyedBy: CodingKeys.self, forKey: .queryResults)
        let rowContainer =  try queryResults.nestedContainer(keyedBy: CodingKeys.self, forKey: .row)
        
        position = try rowContainer.decode(String.self, forKey: .position)
        name_display_last_first = try rowContainer.decode(String.self, forKey: .name_display_last_first)
        weight = Double(try rowContainer.decode(String.self, forKey: .weight))
        birth_country = try rowContainer.decode(String.self, forKey: .birth_country)
        birth_state = try rowContainer.decode(String.self, forKey: .birth_state)
        name_display_first_last = try rowContainer.decode(String.self, forKey: .name_display_first_last)
        college = try rowContainer.decode(String.self, forKey: .college)
        height_inches = Double(try rowContainer.decode(String.self, forKey: .height_inches))
        name_display_roster = try rowContainer.decode(String.self, forKey: .name_display_roster)
        sport_code = try rowContainer.decode(String.self, forKey: .sport_code)
        bats = try rowContainer.decode(String.self, forKey: .bats)
        name_first = try rowContainer.decode(String.self, forKey: .name_first)
        team_code = try rowContainer.decode(String.self, forKey: .team_code)
        birth_city = try rowContainer.decode(String.self, forKey: .birth_city)
        height_feet = Double(try rowContainer.decode(String.self, forKey: .height_feet))
        team_full = try rowContainer.decode(String.self, forKey: .team_full)
        team_abbrev = try rowContainer.decode(String.self, forKey: .team_abbrev)
        throwing_arm = try rowContainer.decode(String.self, forKey: .throwing_arm)
        league = try rowContainer.decode(String.self, forKey: .league)
        position_id = Int(try rowContainer.decode(String.self, forKey: .position_id))
        high_school = try rowContainer.decode(String.self, forKey: .high_school)
        name_use = try rowContainer.decode(String.self, forKey: .name_use)
        player_id = Int(try rowContainer.decode(String.self, forKey: .player_id))
        name_last = try rowContainer.decode(String.self, forKey: .name_last)
        team_id = Int(try rowContainer.decode(String.self, forKey: .team_id))
        service_years = Int(try rowContainer.decode(String.self, forKey: .service_years))
        active_sw = try rowContainer.decode(String.self, forKey: .active_sw)
        
        //Details with date formats
        let dobString = try rowContainer.decode(String.self, forKey: .birth_date)
        birth_date = DateFormatter.mmmddyyyFormat(from: dobString)
        let debutDateString = try rowContainer.decode(String.self, forKey: .pro_debut_date)
        pro_debut_date = DateFormatter.mmmddyyyFormat(from: debutDateString)
    }
}
