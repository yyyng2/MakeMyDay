//
//  ScheduleViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

import FSCalendar
import RealmSwift

class ScheduleViewController: BaseViewController {
    
    lazy var mainView = ScheduleView()
    
    lazy var calendar = mainView.calendar
    
    var calendarHeight: CGFloat = 300
    
    var headerDate: Date?
    var headerString = ""
    
    var dateData: Date?
    
    let scheduleRepository = ScheduleRepository()
    
    var scheduleTasks: Results<Schedule>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
 
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        configureUpdownButton()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        
        calendar.delegate = self
        calendar.dataSource = self
        //print(Realm.Configuration.defaultConfiguration.fileURL)
       
        calendarSwipe()
    }
    
    override internal func configureUI() {
        guard let todayDate = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm) else { return }
        headerDate = todayDate
        headerString = dateFormatToString(date: todayDate, formatStyle: .yyyyMMdd)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.3
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
    }
    
    private func configureUpdownButton() {
        mainView.updownButton.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
    }
    
    private func calendarSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func fetchRealm() {
        guard let date: Date = stringFormatToDate(string: headerString, formatStyle: .yyyyMMdd) else { return }
        guard let formatDate = localDate(date: date, formatStyle: .yyyyMMdd) else { return }
        let selectDate = dateFormatToString(date: formatDate, formatStyle: .yyyyMMdd)
        scheduleTasks = scheduleRepository.fetchFilterDateString(formatDate: selectDate)
        
        mainView.tableView.reloadData()
    }
    
    @objc private func swipeEvent(_ swipe: UISwipeGestureRecognizer) {

        if swipe.direction == .up {
            calendar.setScope(.week, animated: true)
        } else if swipe.direction == .down {
            calendar.setScope(.month, animated: true)
        }
    }
    
    @objc private func buttonEvent() {
        if calendar.scope == .month {
            calendar.setScope(.week, animated: true)
        } else if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
        }
    }
    
    @objc func writeItemTapped() {
        let vc = ScheduleWriteViewController()
        vc.edit = false
        
      
        if let data = dateData {
            guard let selectDay = localDate(date: data, formatStyle: .yyyyMMddEaHHmm) else { return }
            vc.dateData = selectDay
        } else {
            let today = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm)
            let date = today
            vc.dateData = date
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureBackButton() {
 
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
      
        let backBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(backButtonTapped))
      
        if User.themeType {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foreground
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            backBarButtonItem.tintColor = .white
        } else {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            backBarButtonItem.tintColor = .black
        }
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
}
extension ScheduleViewController: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        headerDate = date
        dateData = date
        headerString = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        fetchRealm()
        mainView.tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        calendarHeight = bounds.height
        
        calendar.snp.updateConstraints {
            $0.height.equalTo(calendarHeight)
        }
    
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }

    }
    
    @objc func backButtonTapped() {

        self.navigationController?.popViewController(animated: true)
    }
    
    func moveToDate(date: Date) {
        calendar.select(date, scrollToDate: true)
        dateData = date
        headerString = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        fetchRealm()
        print(scheduleTasks[0])
        mainView.tableView.reloadData()
    }
    
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = HeaderView()
        headerView.sectionLabel.text = headerString
        headerView.writeButton.addTarget(self, action: #selector(writeItemTapped), for: .touchUpInside)

        return headerView
      
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            if User.themeType {
                header.textLabel?.textColor = .white
            } else {
                header.textLabel?.textColor = .black
            }

            header.contentView.backgroundColor = UIColor.clear
            header.textLabel?.font = .systemFont(ofSize: 20, weight: .black)
            header.sizeToFit()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleTasks == nil ? 0 : scheduleTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        if User.themeType {
            cell.backgroundColor = Constants.BaseColor.foreground
        } else {
            cell.backgroundColor = Constants.BaseColor.foregroundColor
        }
      
        let string = dateFormatToString(date: scheduleTasks[indexPath.row].date, formatStyle: .hhmm)
        cell.titleLabel.text = scheduleTasks[indexPath.row].title
        cell.dateLabel.text = string
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ScheduleWriteViewController()
        vc.edit = true
        vc.schedule = scheduleTasks[indexPath.row]
        vc.delegate = self
  
        if let data = dateData {
            vc.dateData = data
        } else {
            let date = stringFormatToDate(string: headerString, formatStyle: .yyyyMMdd)
            vc.dateData = date
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ScheduleViewController: DatePickerDataProtocol {
    func updateDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
    
        let data = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
   
        guard let movoDate = formatter.date(from: data) else {return}
   
        moveToDate(date: movoDate)
        
       
    }
    
}
