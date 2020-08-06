//
//  ErrorAlerts.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-05-06.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class ErrorAlerts {
    var alertController: UIAlertController?
    
    func makeAlertController(title: String, message: String){
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func addAction(title: String) {
        alertController?.addAction(UIAlertAction(title: title, style: .default, handler: { (action: UIAlertAction!) in
//            implement if needed
        }))
    }
}
