//
//  MainTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/13.
//

import UIKit

class MainTableViewCell: BaseTableViewCell{
    
    let backgroundImageView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        return view
    }()
    
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
    
    override func configure() {
        
        backgroundColor = .clear
       
        [backgroundImageView, titleLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
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
