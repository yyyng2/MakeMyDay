//
//  MainProfileTableViewCell.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//

import UIKit

class MainProfileTableViewCell: BaseTableViewCell {
    
    lazy var profileView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
     
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var profileLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero)
      
        label.textColor = themeType().tintColor
    
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    override func configure() {
        backgroundColor = .clear
        
        [profileView, profileLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        profileView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        profileLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileView.snp.trailing).offset(4)
            make.centerY.equalTo(profileView)
            make.width.equalTo(safeAreaLayoutGuide)
        }
    }
    

}
