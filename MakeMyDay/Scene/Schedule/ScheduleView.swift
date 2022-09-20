//
//  ScheduleView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

import FSCalendar

class ScheduleView: BaseView {
    
    lazy var backgroundImageView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    var calendarHeight: CGFloat = 300
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.locale = Locale.current

        calendar.backgroundColor = themeType().objectBackgroundColor
        calendar.appearance.headerTitleColor = themeType().calendarHeaderColor
        calendar.appearance.todayColor = UIColor.green
        calendar.appearance.eventDefaultColor = UIColor.red

        calendar.appearance.titleDefaultColor = themeType().tintColor
        calendar.appearance.selectionColor = themeType().calendarSelectionColor
        calendar.appearance.weekdayTextColor = themeType().tintColor
       
        calendar.appearance.eventSelectionColor = themeType().calendarSelectionColor
         
        calendar.appearance.todaySelectionColor = themeType().calendarSelectionColor
        //color
//        if User.themeType {
//            calendar.backgroundColor = .black
//            calendar.appearance.titleDefaultColor = UIColor.white
//            calendar.appearance.selectionColor = UIColor.systemGray2
//            calendar.appearance.weekdayTextColor = UIColor.white
//            calendar.appearance.eventDefaultColor = UIColor.red
//            calendar.appearance.eventSelectionColor = UIColor.systemGray2
//            calendar.appearance.todayColor = UIColor.green
//            calendar.appearance.todaySelectionColor = UIColor.systemGray2
//
//            calendar.appearance.headerTitleColor = .white
//        } else {
//            calendar.backgroundColor = .white
//            calendar.appearance.titleDefaultColor = UIColor.black
//            calendar.appearance.selectionColor = UIColor.black
//            calendar.appearance.weekdayTextColor = UIColor.black
//            calendar.appearance.eventDefaultColor = UIColor.red
//            calendar.appearance.eventSelectionColor = UIColor.black
//            calendar.appearance.todayColor = UIColor.green
//            calendar.appearance.todaySelectionColor = UIColor.black
//
//            calendar.appearance.headerTitleColor = .black
//        }

      
        //header
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY. MM."
      
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20)
        //weekday name
        calendar.calendarWeekdayView.weekdayLabels[0].text = "Sun"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "Mon"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "Tue"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "Wed"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "Thu"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "Fri"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "Sat"
        return calendar
    }()
    
    let updownButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        button.backgroundColor = themeType().objectBackgroundColor
        button.tintColor = themeType().tintColor
//        if User.themeType {
//            button.backgroundColor = .black
//            button.tintColor = .white
//        } else {
//            button.backgroundColor = .white
//            button.tintColor = .black
//        }
        return button
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
        return view
    }()
    
    let writeButton: CustomWriteButton = {
        let button = CustomWriteButton(frame: .zero)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [backgroundImageView, calendar, updownButton, tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        calendar.snp.makeConstraints { make in
            make.height.equalTo(calendarHeight)
//            make.height.equalTo(bounds.height).multipliedBy(0.5)
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
           
        }
        
        updownButton.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(updownButton.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
     
    }
    
}

