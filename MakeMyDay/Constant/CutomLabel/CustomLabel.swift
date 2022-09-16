//
//  CustomLabel.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class CustomLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        if themeType {
            textColor = .white
        } else {
            textColor = .black
        }
    }
    
}
