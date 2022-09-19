//
//  BaseView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .black
    }
    func setConstraints() {
      
    }
}
