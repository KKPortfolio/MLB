//
//  ViewController.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-04-21.
//  Copyright © 2020 KK. All rights reserved.
//




import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBarTextField: UISearchBar!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBarTextField.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarTextField.placeholder = "Enter Player Name"

        //        shows cancel button
        //        self.searchBarTextField.showsCancelButton = true
        
    }
    
    
    
}
