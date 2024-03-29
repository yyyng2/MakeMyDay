//
//  MainScheduleTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//

import UIKit

class MainScheduleTableViewCell: BaseTableViewCell {
    
    let backgroundImageView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        return view
    }()
    
    let titleLabel: CustomLabel = {
       let label = CustomLabel()
      
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let dateLabel: CustomLabel = {
       let label = CustomLabel()
   
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    override func configure() {
        backgroundColor = themeType().foregroundColor
        
        [backgroundImageView, titleLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(34)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.6)
            make.leading.equalTo(safeAreaLayoutGuide).offset(74)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(74)
        }
    }

}
