//
//  FAQView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/29.
//

import UIKit

class FAQView: BaseView {
    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    lazy var question1Label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = "Q. \("QDday".localized)"
        label.textColor = themeType().tintColor

        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    lazy var answer1Label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = """
                    A. \("ADdayOne".localized)
                    \("    ")\("ADdayTwo".localized)
                    \("    ")\("ADdayThree".localized)
                    """
        label.textColor = themeType().tintColor
        label.numberOfLines = 3

        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    lazy var separateLine1: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = themeType().tintColor
        return view
    }()
    
    lazy var question2Label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = "Q. \("QDelete".localized)"
        label.textColor = themeType().tintColor

        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    lazy var answer2Label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = """
                    A. \("ADeleteOne".localized)
                    \("    ")\("ADeleteTwo".localized)
                    \("    ")\("ADeleteThree".localized)
                    """
        label.textColor = themeType().tintColor
        label.numberOfLines = 3

        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    lazy var separateLine2: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = themeType().tintColor
        return view
    }()
    
    lazy var question3Label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = "Q. \("QTheme".localized)"
        label.textColor = themeType().tintColor

        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    lazy var answer3Label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
        label.text = """
                    A. \("AThemeOne".localized)
                    """
        label.textColor = themeType().tintColor
        label.numberOfLines = 2

        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    lazy var separateLine3: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = themeType().tintColor
        return view
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
        [backgroundView, question1Label, answer1Label, separateLine1, question2Label, answer2Label, separateLine2, question3Label, answer3Label, separateLine3, emailStackView, instaStackView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        question1Label.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        answer1Label.snp.makeConstraints { make in
            make.top.equalTo(question1Label.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        separateLine1.snp.makeConstraints { make in
            make.top.equalTo(answer1Label.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        question2Label.snp.makeConstraints { make in
            make.top.equalTo(separateLine1.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        answer2Label.snp.makeConstraints { make in
            make.top.equalTo(question2Label.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        separateLine2.snp.makeConstraints { make in
            make.top.equalTo(answer2Label.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        question3Label.snp.makeConstraints { make in
            make.top.equalTo(separateLine2.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        answer3Label.snp.makeConstraints { make in
            make.top.equalTo(question3Label.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        separateLine3.snp.makeConstraints { make in
            make.top.equalTo(answer3Label.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        emailStackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(separateLine3.snp.bottom).offset(30)
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
