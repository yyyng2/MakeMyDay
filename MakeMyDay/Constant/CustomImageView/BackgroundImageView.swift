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
        image = themeType().backgroundImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
