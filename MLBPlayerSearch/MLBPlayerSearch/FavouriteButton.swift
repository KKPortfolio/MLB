//
//  FavouriteButton.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-06-18.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation
import UIKit



class FavouriteButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        heartEmpty()
        frame = CGRect(x: 136.0, y: 0.0, width: 100.0, height: 44.0)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tintColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 0.8)
    }
    func heartFill(){
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    func heartEmpty(){
        setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
