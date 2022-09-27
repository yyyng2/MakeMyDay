//
//  TableHeaderView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/18.
//

import UIKit

class DdayTableHeaderView: BaseView {
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textAlignment = .center
        label.textColor = themeType().tintColor

        return label
    }()
    
    override func configure() {
        backgroundColor = .clear
        
        [sectionLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(80)
        }
    }
    
}
