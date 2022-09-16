//
//  DdayTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class DdayTableViewCell: BaseTableViewCell{
    
    let titleLabel: CustomLabel = {
       let label = CustomLabel()
     
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemGray3
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    let countLabel: CustomLabel = {
       let label = CustomLabel()
        return label
    }()
    
    override func configure() {
        if themeType {
            backgroundColor = Constants.BaseColor.foreground
        } else {
            backgroundColor = Constants.BaseColor.foregroundColor
        }
        
        [titleLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(35)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(35)
        }
    }
    

}
