//
//  CustomDayLabel.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/03.
//

import UIKit

class CustomDayLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = themeType().tintColor
        textAlignment = .center
        font = .boldSystemFont(ofSize: 16)
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = themeType().foregroundColor
    }
    
}
