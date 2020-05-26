//
//  ViewModel.swift
//  MLBPlayerSearch
//
//  Created by King Kurt on 2020-05-06.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

struct ViewModel {

    static func JSONParsing(rawData data:Data?, completion: @escaping (Player) -> ()){
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String:Any]
                if let all = json!["search_player_all"] as? [String:Any],
                    let results = all["queryResults"] as? [String:Any],
                    let row = results["row"] as? [String:Any] {
                    if let chosenOne = try? Player(json: row){
                        print("player successfully loaded")
                        completion(chosenOne)
                    }
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
    }
}

