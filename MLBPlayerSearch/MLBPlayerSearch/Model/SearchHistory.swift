//
//  SearchHistory.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-06-07.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation

class SearchHistory: NSObject, NSCoding{
    
//    MARK: properties
    var listOfSearches: [String]?
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("searchTerms")
    
    struct PropertyKey {
        static let listOfSearches = "listOfSearches"
    }
    
    override init() {
        self.listOfSearches = [""]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(listOfSearches, forKey: PropertyKey.listOfSearches)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let searchTerm = aDecoder.decodeObject(forKey: PropertyKey.listOfSearches) as? String
            else {
                print("Unable to decode the name for a listOfSearches object")
                return nil
        }
    }
}


