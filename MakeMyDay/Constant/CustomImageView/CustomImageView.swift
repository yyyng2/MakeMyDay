//
//  CustomImageView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class CustomImageView: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
