//
//  ScheduleTableHeaderView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/18.
//

import UIKit

class HeaderView: BaseView {
    let writeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.backgroundColor = .clear
        if User.themeType {
            button.tintColor = .white
        } else {
            button.tintColor = .black
        }
        return button
    }()
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        if User.themeType {
            label.textColor = .white
        } else {
            label.textColor = .black
        }
        return label
    }()
    
    override func configure() {
        backgroundColor = .clear
        
        [sectionLabel, writeButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(80)
        }
        
        writeButton.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.width.height.equalTo(50)
        }
    }
    
}
