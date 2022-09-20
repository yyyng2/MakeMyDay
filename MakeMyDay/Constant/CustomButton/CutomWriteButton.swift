//
//  CutomWriteButton.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/20.
//

import UIKit

class CustomWriteButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        tintColor = themeType().tintColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
