//
//  MainTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/13.
//

import UIKit

class MainTableViewCell: BaseTableViewCell {
    
    let backgroundImageView: CellShortCustomImageView = {
        let view = CellShortCustomImageView(frame: .zero)
        return view
    }()
    
    let titleLabel: CustomLabel = {
       let label = CustomLabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
   
    
    override func configure() {
        backgroundColor = .clear
       
        [backgroundImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(70)
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    

}
