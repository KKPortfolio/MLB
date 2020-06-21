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
        setImage(UIImage(systemName: "heart"), for: .normal)
        addTarget(self, action: #selector(CustomFavouriteButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(){
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool){
        isOn = bool
        let image = bool ? setImage(UIImage(systemName: "heart.fill"), for: .normal) : setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
