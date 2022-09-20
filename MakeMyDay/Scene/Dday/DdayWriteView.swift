//
//  DdayWriteView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class DdayWriteView: BaseView{
    lazy var backgroundImageView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let infoeLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "D-day 이름을 적어볼까요? 날짜를 탭하면 변경도 가능합니다!"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
      
        return label
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.layer.borderWidth = 3
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderColor = themeType().whiteBlackBorderColor
//        if User.themeType {
//            label.layer.borderColor = UIColor.white.cgColor
//        } else {
//            label.layer.borderColor = UIColor.black.cgColor
//        }
      
        return label
    }()
    
    let dateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = .clear
        return button
    }()
    
    let titleTextField: UITextField = {
       let field = UITextField()
        field.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        field.layer.borderWidth = 3
        field.clipsToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .clear
        field.placeholder = " D-day 제목"
        field.attributedPlaceholder = NSAttributedString(string: " D-day 제목", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        field.textColor = themeType().tintColor
        field.layer.borderColor = themeType().whiteBlackBorderColor
//        if User.themeType {
//            field.textColor = .white
//            field.layer.borderColor = UIColor.white.cgColor
//        } else {
//            field.textColor = .black
//            field.layer.borderColor = UIColor.black.cgColor
//        }
        field.becomeFirstResponder()
        field.font = .boldSystemFont(ofSize: 20)
        return field
    }()

    
    override func configure() {
        [backgroundImageView, infoeLabel, dateLabel, dateButton, titleTextField].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        infoeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(infoeLabel.snp.bottom).offset(16)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(28)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(28)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(-1)
            make.leading.equalTo(dateLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
     

    }

}
