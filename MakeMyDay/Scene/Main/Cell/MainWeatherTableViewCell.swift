//
//  MainWeatherTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/11.
//

import UIKit

class MainWeatherTableViewCell: BaseTableViewCell {
    
    let backgroundImageView: CellLargeCustomImageView = {
        let view = CellLargeCustomImageView(frame: .zero)
        return view
    }()
    
    let titleLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    let tempLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
   
    
    override func configure() {
        backgroundColor = .clear
       
        [backgroundImageView, titleLabel, tempLabel].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(34)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(74)
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(74)
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    

}

