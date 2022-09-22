//
//  SettingTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class SettingTableViewCell: BaseTableViewCell {
    let backgroundImageView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        return view
    }()
    
    let titleLabel: CustomLabel = {
       let label = CustomLabel()
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
        [backgroundImageView, titleLabel, rightArrowImageView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(40)
            make.trailing.equalTo(rightArrowImageView).offset(-20)
        }
        rightArrowImageView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.width.equalTo(rightArrowImageView.snp.height).multipliedBy(0.6)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
