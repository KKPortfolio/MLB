//
//  Player.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-05-06.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation

struct Player {
    let position:String?
    let birth_country:String?
    let weight:String?
    let birth_state:String?
    let name_display_first_last:String?
    let college:String?
    let height_inches:String?
    let name_display_roster:String?
    let sport_code:String?
    let bats:String?
    let name_first:String?
    let team_code:String?
    let birth_city:String?
    let height_feet:String?
    let pro_debut_date:String?
    let team_full:String?
    let team_abbrev:String?
    let birth_date:String?
    let throwing_arm:String?
    let league:String?
    let name_display_last_first:String?
    let position_id:String?
    let high_school:String?
    let name_use:String?
    let player_id:String?
    let name_last:String?
    let team_id:String?
    let service_years:String?
    let active_sw:String?

    enum SerializationError:Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json:[String:Any]) throws {
        guard let position = json["position"] as? String else { throw SerializationError.missing("posittion missing")}
        guard let birth_country = json["birth_country"] as? String else { throw SerializationError.missing("birth_country missing")}
        guard let weight = json["weight"] as? String else { throw SerializationError.missing("weight missing")}
        guard let birth_state = json["birth_state"] as? String else { throw SerializationError.missing("birth_state missing")}
        guard let name_display_first_last = json["name_display_first_last"] as? String else { throw SerializationError.missing("name_display_first_last missing")}
        guard let college = json["college"] as? String else { throw SerializationError.missing("college missing")}
        guard let height_inches = json["height_inches"] as? String else { throw SerializationError.missing("height_inches missing")}
        guard let name_display_roster = json["name_display_roster"] as? String else { throw SerializationError.missing("name_display_roster missing")}
        guard let sport_code = json["sport_code"] as? String else { throw SerializationError.missing("sport_code missing")}
        guard let bats = json["bats"] as? String else { throw SerializationError.missing("bats missing")}
        guard let name_first = json["name_first"] as? String else { throw SerializationError.missing("name_first missing")}
        guard let team_code = json["team_code"] as? String else { throw SerializationError.missing("team_code missing")}
        guard let birth_city = json["birth_city"] as? String else { throw SerializationError.missing("birth_city missing")}
        guard let height_feet = json["height_feet"] as? String else { throw SerializationError.missing("height_feet missing")}
        guard let pro_debut_date = json["pro_debut_date"] as? String else { throw SerializationError.missing("pro_debut_date missing")}
        guard let team_full = json["team_full"] as? String else { throw SerializationError.missing("team_full missing")}
        guard let team_abbrev = json["team_abbrev"] as? String else { throw SerializationError.missing("team_abbrev missing")}
        guard let birth_date = json["birth_date"] as? String else { throw SerializationError.missing("birth_date missing")}
        guard let throwing_arm = json["throws"] as? String else { throw SerializationError.missing("throwing_arm missing")}
        guard let league = json["league"] as? String else { throw SerializationError.missing("league missing")}
        guard let name_display_last_first = json["name_display_last_first"] as? String else { throw SerializationError.missing("name_display_last_first missing")}
        guard let position_id = json["position_id"] as? String else { throw SerializationError.missing("position_id missing")}
        guard let high_school = json["high_school"] as? String else { throw SerializationError.missing("high_school missing")}
        guard let name_use = json["name_use"] as? String else { throw SerializationError.missing("name_use missing")}
        guard let player_id = json["player_id"] as? String else { throw SerializationError.missing("player_id missing")}
        guard let name_last = json["name_last"] as? String else { throw SerializationError.missing("name_last missing")}
        guard let team_id = json["team_id"] as? String else { throw SerializationError.missing("team_id missing")}
        guard let service_years = json["service_years"] as? String else { throw SerializationError.missing("service_years missing")}
        guard let active_sw = json["active_sw"] as? String else { throw SerializationError.missing("active_sw missing")}
        
        self.position = position
        self.birth_country = birth_country
        self.weight = weight
        self.birth_state = birth_state
        self.name_display_first_last = name_display_first_last
        self.college = college
        self.height_inches = height_inches
        self.name_display_roster = name_display_roster
        self.sport_code = sport_code
        self.bats = bats
        self.name_first = name_first
        self.team_code = team_code
        self.birth_city = birth_city
        self.height_feet = height_feet
        self.pro_debut_date = pro_debut_date
        self.team_full = team_full
        self.team_abbrev = team_abbrev
        self.birth_date = birth_date
        self.throwing_arm = throwing_arm
        self.league = league
        self.name_display_last_first = name_display_last_first
        self.position_id = position_id
        self.high_school = high_school
        self.name_use = name_use
        self.player_id = player_id
        self.name_last = name_last
        self.team_id = team_id
        self.service_years = service_years
        self.active_sw = active_sw
    }
}

