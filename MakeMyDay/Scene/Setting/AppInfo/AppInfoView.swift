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
        label.text = "Illustrator_ Heejeong Chae."
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
 
        label.textColor = themeType().tintColor
        return label
    }()
    
    let emailLabel: CustomLabel = {
       let label = CustomLabel()
        label.text = "Email: yyyng2@gmail.com"
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
 
        label.textColor = themeType().tintColor
        return label
    }()
    
    let emailButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.setImage(UIImage(systemName: "mail.fill"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    let instaLabel: CustomLabel = {
       let label = CustomLabel()
        label.text = "Insta: @makemyday_app"
        label.textColor = themeType().tintColor

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
 
        label.textColor = themeType().tintColor
        return label
    }()
    
    let instaButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.setImage(UIImage(systemName: "safari.fill"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var instaStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [instaLabel, instaButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    override func configure() {
        backgroundColor = .clear
        [backgroundView, profileView, profileLabel, developerLabel, illustratorLabel, emailStackView, instaStackView].forEach {
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
        emailStackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(illustratorLabel.snp.bottom).offset(30)
        }
        instaStackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(emailStackView.snp.bottom).offset(8)
            make.width.equalTo(emailStackView.snp.width)
        }
        instaButton.snp.makeConstraints { make in
            make.width.equalTo(emailButton.snp.width)
        }
    }
}
