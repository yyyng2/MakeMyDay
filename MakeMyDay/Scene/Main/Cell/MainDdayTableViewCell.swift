//
//  MainDdayTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//

import UIKit

class MainDdayTableViewCell: BaseTableViewCell {
    
    let backgroundImageView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        return view
    }()
    
    let titleLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dateLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    let countLabel: CustomLabel = {
       let label = CustomLabel()
        label.textColor = themeType().countTextColor
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override func configure() {
        backgroundColor = themeType().foregroundColor
        
        [backgroundImageView, titleLabel, dateLabel, countLabel].forEach {
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
            make.trailing.equalTo(countLabel.snp.leading).offset(-8)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(74)
            make.trailing.equalTo(countLabel.snp.leading).offset(-8)
        }
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-12)
            make.height.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(countLabel.snp.height).multipliedBy(2)
        }
    }
    

}
