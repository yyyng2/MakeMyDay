//
//  MainView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

class MainView: BaseView {

    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero)
  
        label.text = "0000년 00월 00일 오전 00:00"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorColor = .clear
        return view
    }()
    
    let writeButton: CustomWriteButton = {
        let button = CustomWriteButton(frame: .zero)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        let pointSize: CGFloat = 15
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.backgroundColor = themeType().foregroundColor
        button.tintColor = themeType().tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let alarmButton: UIButton = {
       let button = UIButton()
        button.tintColor = themeType().tintColor
        button.setImage(UIImage(systemName: "alarm.fill"), for: .normal)
        return button
    }()
    
    let scheduleWriteButton: CustomWriteButton = {
        let button = CustomWriteButton(frame: .zero)
        button.setImage(themeType().tabBarScheduleItem, for: .normal)
        button.backgroundColor = themeType().foregroundColor
        button.tintColor = themeType().tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    let ddayWriteButton: CustomWriteButton = {
        let button = CustomWriteButton(frame: .zero)
        button.setImage(themeType().tabBarDdayItem, for: .normal)
        button.backgroundColor = themeType().foregroundColor
        button.tintColor = themeType().tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
 
    
    override func configure() {
        
        [backgroundView, dateLabel, alarmButton, tableView, writeButton, scheduleWriteButton, ddayWriteButton].forEach {
            self.addSubview($0)
        }
    }
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(dateLabel.snp.trailing).offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.145)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        
        scheduleWriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(writeButton.snp.top).offset(-8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.145)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        
        ddayWriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(scheduleWriteButton.snp.top).offset(-8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.145)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }

    }
    
}
