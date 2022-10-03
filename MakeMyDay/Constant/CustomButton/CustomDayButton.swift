//
//  CustomDayButton.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/03.
//

import UIKit

class CustomDayButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .clear
        tintColor = .clear
    }
}
