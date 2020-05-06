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
    
    func genericExecute<T: Decodable>(_ request: APIRequest, completion: @escaping (Result<T, Error>)->()) {
        guard let url = URL(string: request.baseURL) else {
            completion(.failure(NetworkError.missing("URL")))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.missing("Data")))
                return
            }
            
            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(ParseError.generic))
                return
            }
            
            completion(.success(response))
        }
        
        task.resume()
    }
    
    func execute(_ request: APIRequest, completion: @escaping (Result<Data, Error>)->()) {
        guard let url = URL(string: request.baseURL) else {
            completion(.failure(NetworkError.missing("URL")))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, responseObj, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.missing("Data")))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
