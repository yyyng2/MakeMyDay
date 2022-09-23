//
//  MainView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

import Hover

class MainView: BaseView {

    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
//    let profileBackgroundView: BaseView = {
//        let view = BaseView()
//        view.backgroundColor = .clear
//        return view
//    }()
//    
//    let profileView: CustomImageView = {
//        let view = CustomImageView(frame: .zero)
//        view.image = themeType().profileImage
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
//    
//    let profileLabel: CustomLabel = {
//        let label = CustomLabel(frame: .zero)
//        label.text = "D"
//        label.textColor = themeType().tintColor
//
//        label.textAlignment = .center
//        label.font = .boldSystemFont(ofSize: 12)
//        return label
//    }()
    
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
        button.backgroundColor = themeType().foregroundColor
        button.tintColor = themeType().tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
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
        
//        [backgroundView, profileBackgroundView, profileView, profileLabel, dateLabel, tableView, writeButton, scheduleWriteButton, ddayWriteButton].forEach {
//            self.addSubview($0)
//        }
        
        [backgroundView, dateLabel, tableView, writeButton, scheduleWriteButton, ddayWriteButton].forEach {
            self.addSubview($0)
        }
    }
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
//        profileBackgroundView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(0.1)
//            make.centerX.equalTo(backgroundView)
//            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.09)
//            make.width.equalTo(profileBackgroundView.snp.height)
//        }
//        profileView.snp.makeConstraints { make in
//            make.top.equalTo(profileBackgroundView.snp.top)
//            make.height.equalTo(profileBackgroundView.snp.height).multipliedBy(0.7)
//            make.centerX.equalTo(profileBackgroundView)
//        }
//        profileLabel.snp.makeConstraints { make in
//            make.top.equalTo(profileView.snp.bottom)
//            make.centerX.equalTo(profileView)
//            make.width.equalTo(profileBackgroundView.snp.width)
//        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
       //     make.top.equalTo(profileBackgroundView.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        
        scheduleWriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(writeButton.snp.top).offset(-8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        
        ddayWriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(scheduleWriteButton.snp.top).offset(-8)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }

    }
    
}
