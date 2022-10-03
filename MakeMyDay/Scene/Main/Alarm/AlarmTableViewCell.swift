//
//  AlarmTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/03.
//

import UIKit

class SetAlarmTableViewCell: BaseTableViewCell {
    
    let backgroundImageView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        return view
    }()
    
    let dayLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let timeLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var statusLabel: CustomLabel = {
       let label = CustomLabel()
        label.textColor = themeType().countTextColor
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let rightArrowImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .systemGray3
        return view
    }()
    
    override func configure() {
        backgroundColor = themeType().foregroundColor
        
        [backgroundImageView, dayLabel, timeLabel, statusLabel, rightArrowImageView].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(35)
        }
        timeLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(rightArrowImageView).offset(-10)
            make.height.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(statusLabel.snp.height).multipliedBy(2)
        }
        rightArrowImageView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.width.equalTo(rightArrowImageView.snp.height).multipliedBy(0.6)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
