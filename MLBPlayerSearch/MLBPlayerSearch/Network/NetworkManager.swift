//
//  NetworkManager.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-05-06.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    var baseURL = "http://lookup-service-prod.mlb.com/json/named.search_player_all.bam?sport_code='mlb'&active_sw='Y'&name_part='"
    func execute(searchTerm: String, completion: @escaping (Data) -> ()) {
        let url  = "\(baseURL)\(searchTerm)%25'&search_player_all"
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            completion(data!)
        }
        task.resume()
    }
}
