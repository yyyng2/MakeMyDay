//
//  ScheduleDatePIckerView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/15.
//

import UIKit

class DatePickerView: BaseView {
    let backgroundView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .clear
        return view
    }()
    
    let pickerBackground: UIImageView = {
       let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.backgroundColor = .systemGray3
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()

        picker.preferredDatePickerStyle = .inline
         
        picker.locale = Locale.current
        picker.calendar.locale = Locale.current
        picker.tintColor = UIColor.systemMint
        picker.timeZone = .autoupdatingCurrent
        picker.datePickerMode = .dateAndTime
        picker.sizeToFit()
        picker.backgroundColor = .clear
        return picker
    }()
    
    let pickerLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Time"
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = ""
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 35, weight: .black)
        label.isHidden = true
        return label
    }()
    
    let alarmLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Alarm"
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    let alarmSwitchButton: CustomDaySwitchButton = {
       let button = CustomDaySwitchButton()
        button.isHidden = true
        return button
    }()
    
    let doneButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setTitle("선택", for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let whiteLine: UIImageView = {
       let line = UIImageView()
        line.backgroundColor = .white
        return line
    }()
    
    let cancelButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .red
        
       let button = UIButton(configuration: config)
        button.setTitle("취소", for: .normal)
    
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        
        view.layer.borderColor = UIColor.white.cgColor
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .systemGray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {        
        [backgroundView, pickerBackground, datePicker, dayLabel, pickerLabel, alarmLabel, alarmSwitchButton,buttonStackView, whiteLine].forEach {
            addSubview($0)
        }
    }
    
    func configureLayer() {
        pickerBackground.layer.cornerRadius = 10
        pickerBackground.clipsToBounds = true
        pickerBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        buttonStackView.layer.cornerRadius = 10
        buttonStackView.clipsToBounds = true
        buttonStackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        pickerBackground.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
        }
        
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView.snp.centerY).multipliedBy(0.6)
        }
        
        pickerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(datePicker)
            make.leading.equalTo(pickerBackground.snp.leading).offset(16)
        }
        
        alarmLabel.snp.makeConstraints { make in
            make.centerY.equalTo(alarmSwitchButton)
            make.trailing.equalTo(alarmSwitchButton.snp.leading).offset(-8)
        }
     
        alarmSwitchButton.snp.makeConstraints { make in
            make.bottom.equalTo(buttonStackView.snp.top).offset(-20)
            make.trailing.equalTo(buttonStackView.snp.trailing).offset(-8)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(datePicker.snp.width)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
        
        whiteLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(buttonStackView.snp.height)
            make.center.equalTo(buttonStackView)
        }
    }
}
