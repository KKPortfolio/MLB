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
    func execute(searchTerm: String){
        guard let url = URL(string: "\(baseURL)\(searchTerm)%25'&search_player_all") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            print("This is the result from API \n\n \(dataString) \n\n")
            do {
                
            } catch let jsonErr {
                print("Error in serializing JSON: ", jsonErr)
            }
        }.resume()
    }
    
    
//    func genericExecute<T: Decodable>(_ request: APIRequest, completion: @escaping (Result<T, Error>)->()) {
//        guard let url = URL(string: request.baseURL) else {
//            completion(.failure(NetworkError.missing("URL")))
//            return
//        }
//
//        let urlRequest = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NetworkError.missing("Data")))
//                return
//            }
//
//            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
//                completion(.failure(ParseError.generic))
//                return
//            }
//
//            completion(.success(response))
//        }
//
//        task.resume()
//    }
//
//    func execute(_ request: APIRequest, completion: @escaping (Result<Data, Error>)->()) {
//        guard let url = URL(string: request.baseURL) else {
//            completion(.failure(NetworkError.missing("URL")))
//            return
//        }
//
//        let urlRequest = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, responseObj, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NetworkError.missing("Data")))
//                return
//            }
//            completion(.success(data))
//        }
//        task.resume()
//    }
}
