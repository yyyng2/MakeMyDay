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
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.locale = Locale(identifier: "ko_KR")

        //color
        if themeType {
            calendar.backgroundColor = .black
            calendar.appearance.titleDefaultColor = UIColor.white
            calendar.appearance.selectionColor = UIColor.systemGray2
            calendar.appearance.weekdayTextColor = UIColor.white
            calendar.appearance.eventDefaultColor = UIColor.red
            calendar.appearance.eventSelectionColor = UIColor.systemGray2
            calendar.appearance.todayColor = UIColor.green
            calendar.appearance.todaySelectionColor = UIColor.systemGray2
            
            calendar.appearance.headerTitleColor = .white
        } else {
            calendar.backgroundColor = .white
            calendar.appearance.titleDefaultColor = UIColor.black
            calendar.appearance.selectionColor = UIColor.black
            calendar.appearance.weekdayTextColor = UIColor.black
            calendar.appearance.eventDefaultColor = UIColor.red
            calendar.appearance.eventSelectionColor = UIColor.black
            calendar.appearance.todayColor = UIColor.green
            calendar.appearance.todaySelectionColor = UIColor.black
            
            calendar.appearance.headerTitleColor = .black
        }

      
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
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [backgroundImageView, calendar, tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        calendar.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
//            make.height.equalTo(bounds.height).multipliedBy(0.5)
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)

           
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

