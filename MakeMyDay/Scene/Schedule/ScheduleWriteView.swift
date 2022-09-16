//
//  ScheduleWriteView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/15.
//

import UIKit

class ScheduleWriteView: BaseView {
    lazy var backgroundImageView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let infoeLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "일정을 적어볼까요? 날짜를 탭하면 변경도 가능합니다!"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
      
        return label
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        if themeType {
            label.layer.borderColor = UIColor.white.cgColor
            label.layer.borderWidth = 1
        } else {
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1
        }
      
        return label
    }()
    
    let dateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = .clear
        return button
    }()
    
    let scheduleTextView: UITextView = {
       let view = UITextView()
        view.backgroundColor = .clear
        if themeType {
            view.textColor = .white
        } else {
            view.textColor = .black
        }
        view.becomeFirstResponder()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()

    
    override func configure() {
        [backgroundImageView, infoeLabel, dateLabel, dateButton, scheduleTextView].forEach {
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
            make.height.equalTo(20)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(20)
        }
        
        scheduleTextView.snp.makeConstraints { make in
            make.top.left.equalTo(dateLabel).offset(20)
            make.right.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.55)
        }
     

    }
}
