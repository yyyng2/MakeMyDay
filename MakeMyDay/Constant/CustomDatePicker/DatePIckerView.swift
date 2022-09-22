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
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
        
         } else {
             picker.preferredDatePickerStyle = .automatic
         }
        picker.layer.cornerRadius = 10
        picker.layer.borderColor = UIColor.white.cgColor
        picker.layer.borderWidth = 1
        picker.clipsToBounds = true
        picker.locale = Locale(identifier: "ko_KR")
        picker.calendar.locale = Locale(identifier: "ko_KR")
        picker.tintColor = UIColor.systemMint
        picker.timeZone = .autoupdatingCurrent
        picker.datePickerMode = .dateAndTime
        picker.sizeToFit()
        picker.backgroundColor = .systemGray3
        return picker
    }()
    
    let doneButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.setTitle("선택", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .systemGray3
        return button
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

        
        [backgroundView, datePicker, doneButton].forEach {
            addSubview($0)
        }
    }
    
    func configureLayer() {
        datePicker.layer.cornerRadius = 10
        datePicker.clipsToBounds = true
        datePicker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        doneButton.layer.cornerRadius = 10
        doneButton.clipsToBounds = true
        doneButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(datePicker.snp.width)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}