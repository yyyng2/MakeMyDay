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

        //Color
        calendar.backgroundColor = themeType().objectBackgroundColor
        calendar.appearance.headerTitleColor = themeType().calendarHeaderColor
        calendar.appearance.todayColor = themeType().countTextColor
        calendar.appearance.eventDefaultColor = UIColor.red

        calendar.appearance.titleDefaultColor = themeType().tintColor
        calendar.appearance.selectionColor = themeType().calendarSelectionColor
        calendar.appearance.weekdayTextColor = themeType().tintColor
       
        calendar.appearance.eventSelectionColor = themeType().calendarSelectionColor
         
        calendar.appearance.todaySelectionColor = themeType().calendarSelectionColor

      
        //header
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY. MM."
      
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20)
        //weekday name
        calendar.calendarWeekdayView.weekdayLabels[0].text = "sun".localized
        calendar.calendarWeekdayView.weekdayLabels[1].text = "mon".localized
        calendar.calendarWeekdayView.weekdayLabels[2].text = "tue".localized
        calendar.calendarWeekdayView.weekdayLabels[3].text = "wed".localized
        calendar.calendarWeekdayView.weekdayLabels[4].text = "thu".localized
        calendar.calendarWeekdayView.weekdayLabels[5].text = "fri".localized
        calendar.calendarWeekdayView.weekdayLabels[6].text = "sat".localized
        return calendar
    }()
    
    let updownButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        button.backgroundColor = themeType().objectBackgroundColor
        button.tintColor = themeType().tintColor

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [backgroundImageView, calendar, updownButton, tableView, writeButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        calendar.snp.makeConstraints { make in
            make.height.equalTo(calendarHeight)
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
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.145)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        
    }
    
}

