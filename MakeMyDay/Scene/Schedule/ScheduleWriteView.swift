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
        [backgroundImageView, infoLabel, dateLabel, dateButton, scheduleTextView].forEach {
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
            make.top.equalTo(infoLabel.snp.bottom).offset(8)
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
