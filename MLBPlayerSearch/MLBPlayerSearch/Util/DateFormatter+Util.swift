//
//  DateFormatter+Util.swift
//  MLBPlayerSearch
//
//  Created by Mark Kim on 2020-05-31.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func mmmddyyyFormat(from dateString: String) -> String? {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        guard let convertedDate = defaultDateFormatter.date(from: dateString) else {
            return nil
        }
        return dateFormatterPrint.string(from: convertedDate) // Feb 01,2018
    }
    
    static var defaultDateFormatter: DateFormatter {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatterGet
    }
}
