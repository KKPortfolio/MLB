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
//    use json as completion handler
    func execute(searchTerm: String, completion: @escaping (Data) -> ()) {
        let url  = "\(baseURL)\(searchTerm)%25'&search_player_all"
        let request = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            let data = data!
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String:Any]
//                } catch {
//                    print(error.localizedDescription)
//                }
//                completion(data)
//            }
            completion(data!)
        }
        task.resume()
//        guard let url = URL(string: "\(baseURL)\(searchTerm)%25'&search_player_all") else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else { return }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [ String : Any]
//                if let all = json!["search_player_all"] as? [ String : Any],
//                    let results = all["queryResults"] as? [String : Any],
//                    let row = results["row"] as? [String : Any],
//                    let data = row["team_full"] {
//                    print(data)
//                }
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//        }.resume()
    }
}
