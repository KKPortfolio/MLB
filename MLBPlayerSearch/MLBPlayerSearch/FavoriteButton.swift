//
//  FavoriteButton.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-06-18.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation
import UIKit



class FavoriteButton: UIButton {
//    class func favoriteButtonFilled() -> UIButton {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        return button
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        setImage(UIImage(systemName: "heart"), for: .normal)
        frame = CGRect(x: 136.0, y: 0.0, width: 100.0, height: 44.0)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tintColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 0.8)
    }
}
