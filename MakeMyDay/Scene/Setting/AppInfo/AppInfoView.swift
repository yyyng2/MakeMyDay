//
//  AppInfoView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class AppInfoView: BaseView {
    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    lazy var profileView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        view.image = themeType().profileImage
 
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var profileLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = "Make My Day"
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    let developerLabel: CustomLabel = {
       let label = CustomLabel()
        label.text = "Make My Day"
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "Developer_ Dongyeong Kim."
                   
                    
        label.textColor = themeType().tintColor
        return label
    }()
    
    let illustratorLabel: CustomLabel = {
       let label = CustomLabel()
        label.text = " Illustrator_ Heejeong Chae."
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
 
        label.textColor = themeType().tintColor
        return label
    }()
    
    override func configure() {
        backgroundColor = .clear
        [backgroundView, profileView, profileLabel, developerLabel, illustratorLabel].forEach {
            addSubview($0)
        }
    }
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        profileView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.15)
            make.height.equalTo(profileView.snp.width)
        }
        profileLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileView.snp.bottom).offset(8)
        }
        developerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
        }
        illustratorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(developerLabel.snp.bottom).offset(8)
        }
    }
}
