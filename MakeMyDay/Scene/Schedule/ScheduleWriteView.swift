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
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = themeType().foregroundColor
        label.font = .boldSystemFont(ofSize: 16)
      
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
        view.backgroundColor = themeType().foregroundColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.textColor = themeType().tintColor
        view.becomeFirstResponder()
        view.font = .boldSystemFont(ofSize: 20)
        view.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
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
            make.top.equalTo(infoeLabel.snp.bottom).offset(8)
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
        
        scheduleTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(dateLabel.snp.leading)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.43)
        }
     

    }
}
