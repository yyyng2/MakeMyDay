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
    
    let infoLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "writeInfo".localized
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
      
        return label
    }()
    
    let dateLabel: CustomDayLabel = {
        let label = CustomDayLabel()
        return label
    }()
    
    let dateButton: CustomDayButton = {
        let button = CustomDayButton()
        return button
    }()
    
    let titleTextField: UITextField = {
       let field = UITextField()
        field.backgroundColor = .clear
        field.placeholder = "ddayPlaceholder".localized
        field.attributedPlaceholder = NSAttributedString(string: "ddayPlaceholder".localized, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        field.textColor = themeType().tintColor
        field.becomeFirstResponder()
        field.font = .boldSystemFont(ofSize: 20)
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: field.frame.height))
        field.leftView = leftPadding
        field.leftViewMode = UITextField.ViewMode.always

        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: field.frame.height))
        field.rightView = rightPadding
        field.rightViewMode = UITextField.ViewMode.always
        return field
    }()

    let borderView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = themeType().foregroundColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    let dayPlusLabel: UILabel = {
       let label = UILabel()
        label.textColor = themeType().tintColor
        label.text = "ddaySwitchInfo".localized
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dayPlusSwitchButton: CustomDaySwitchButton = {
       let button = CustomDaySwitchButton()
        return button
    }()
    
    override func configure() {
        [backgroundImageView, infoLabel, dateLabel, dateButton, borderView, titleTextField, dayPlusLabel, dayPlusSwitchButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(16)
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
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(dateLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(dateLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.85)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        
        dayPlusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayPlusSwitchButton)
            make.trailing.equalTo(dayPlusSwitchButton.snp.leading).offset(-8)
            make.leading.equalTo(dateLabel.snp.leading)
        }
     
        dayPlusSwitchButton.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.trailing.equalTo(titleTextField.snp.trailing)
            
        }
    }

}
