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

    var api = "http://lookup-service-prod.mlb.com"
    var endpoint = "/json/named.search_player_all.bam?sport_code='mlb'&active_sw='Y'&name_part="
    var postURLString: String?
    
    func execute(searchTerm: String, completion: @escaping (Data) -> ()) {
        let searchTermSplit = searchTerm.split(separator: " ")
        if searchTermSplit.count != 1 {
            let urlString = "\(api)\(endpoint)'\(searchTermSplit[0])%20\(searchTermSplit[1])'"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    completion(data!)
                }
                task.resume()
            } else {
                print("could not open url, it was nil")
            }
        } else {
            let urlString = "\(api)\(endpoint)'\(searchTermSplit[0])%25'"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
                    completion(data!)
                }
                task.resume()
            } else {
                print("could not open url, it was nil")
            }
        }
        
    }
}
