//
//  BackgroundView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/14.
//

import UIKit

class BackgroundImageView: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentMode = .scaleAspectFill

        if themeType {
            image = UIImage(named: "background_black")
        } else {
            image = UIImage(named: "background_color")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
