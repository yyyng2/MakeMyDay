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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = UIColor.clear
        tintColor = themeType().tintColor
    }
}
