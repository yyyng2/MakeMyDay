//
//  NavTitleView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class NavTitleView: BaseView{
    let profileView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        view.image = themeType().profileImage
 
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    let profileLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = "D"
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [profileView, profileLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        profileView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.height.equalTo(profileView.snp.width)
            make.top.equalToSuperview()
        }
        profileLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileView.snp.bottom).offset(8)
        }
    }
}
