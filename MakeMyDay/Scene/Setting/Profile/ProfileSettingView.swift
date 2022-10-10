//
//  ProfileSettingView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//

import UIKit

class ProfileSettingView: BaseView {
    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let imagePicker: UIImagePickerController = {
        var picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
 
        return picker
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = themeType().backgroundColor
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let loadImageButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "loadImage".localized
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    let nicknameTextField: UITextField = {
       let field = UITextField()
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(string: " \("nicknamePlaceholder".localized)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        field.textColor = themeType().tintColor
        field.becomeFirstResponder()
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: field.frame.height))
        field.leftView = leftPadding
        field.leftViewMode = UITextField.ViewMode.always

        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: field.frame.height))
        field.rightView = rightPadding
        field.rightViewMode = UITextField.ViewMode.always
        
        field.font = .boldSystemFont(ofSize: 20)
        return field
    }()
    
    let borderView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = themeType().foregroundColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let resetButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "reset".localized
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    override func configure() {
        [backgroundView, imageView, loadImageButton, resetButton, borderView, nicknameTextField].forEach {
            addSubview($0)
        }
    }
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.width.height.equalTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.85)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.85)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        loadImageButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.width.height.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.width.height.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(1.4)
        }
    }
}
