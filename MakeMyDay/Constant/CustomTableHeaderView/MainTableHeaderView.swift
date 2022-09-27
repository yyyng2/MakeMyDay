//
//  MainTableHeaderView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//

import UIKit

class MainTableHeaderView: BaseView {
    
    let profileView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        view.image = themeType().profileImage
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let profileLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = "D"
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
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        profileLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileView.snp.trailing)
            make.centerY.equalTo(profileView)
            make.width.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
