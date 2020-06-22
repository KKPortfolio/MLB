//
//  CustomFavouriteButton.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-06-21.
//  Copyright © 2020 KK. All rights reserved.
//

import UIKit

class CustomFavouriteButton: UIButton {
    
    var isOn = false
    var isFavourite = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }

    func initButton(){
        frame = CGRect(x: 138.0, y: 0.0, width: 100.0, height: 44.0)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tintColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 0.8)
        addTarget(self, action: #selector(CustomFavouriteButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(){
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool){
        isOn = bool
        if bool {
            setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavourite = true
        } else {
            setImage(UIImage(systemName: "heart"), for: .normal)
            isFavourite = false
        }
    }
    
    func emptyHeart(){
        setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func fillHeart(){
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
}
