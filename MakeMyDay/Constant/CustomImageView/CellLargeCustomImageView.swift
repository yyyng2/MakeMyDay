//
//  CellLargeCustomImageView.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/11.
//

import UIKit

class CellLargeCustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        configureBackgroundImage()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackgroundImage() {
        image = themeType().bubbleLarge
    }
    
}
