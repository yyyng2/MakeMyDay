//
//  ScheduleViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

import FSCalendar

class ScheduleViewController: BaseViewController {
    
    lazy var mainView = ScheduleView()
    
    lazy var calendar = mainView.calendar
    
    var headerString = ""
    
    var dateData: Date?
    
    override func loadView() {
        super.loadView()
 
        self.view = mainView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0.3
        
        calendar.scope = .month
//        calendar.scope = .week
       
        calendarSwipe()
    }
    
    override func configureUI() {
        headerString = dateFormatToString(date: Date(), formatStyle: .yyyyMMdd)
    }
    
    private func calendarSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {

        if swipe.direction == .up {
            calendar.setScope(.week, animated: true)
        } else if swipe.direction == .down {
            calendar.setScope(.month, animated: true)
        }
        
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
        if themeType {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foreground
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }

       
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
}
extension ScheduleViewController: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateData = date
        headerString = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        mainView.tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
//        calendar.frame.size.height = bounds.height
        print(bounds.height,"aa",calendar.frame.origin)
        
        if calendar.scope == .month {
            calendar.snp.makeConstraints { make in
          
//                make.height.equalTo(calendar.frame.size.height).multipliedBy(5)
//                make.height.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.5)
                make.height.equalTo(self.view).multipliedBy(0.5)
                make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            }
            mainView.tableView.snp.makeConstraints { make in
                make.top.equalTo(calendar.snp.bottom)
                make.leading.trailing.bottom.equalTo(self.view)
              
            }
            print(calendar.scope,"aa")
        } else if calendar.scope == .week {
       
            calendar.snp.makeConstraints { make in
                make.height.equalTo(self.view).multipliedBy(0.2)
                make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            }
            mainView.tableView.snp.makeConstraints { make in
                make.top.equalTo(calendar.snp.bottom)
                make.leading.trailing.bottom.equalTo(self.view)
            }
            print(calendar.scope,"bb")
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
        mainView.tableView.reloadData()
    }
    
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerString
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            if themeType {
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
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        if themeType {
            cell.backgroundColor = Constants.BaseColor.foreground
        } else {
            cell.backgroundColor = Constants.BaseColor.foregroundColor
        }
        cell.titleLabel.text = "test"
        cell.dateLabel.text = "2022.08.01"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ScheduleWriteViewController()
        
        vc.delegate = self
        
        let backBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(backButtonTapped))
   
        if themeType {
            backBarButtonItem.tintColor = .white
        } else {
            backBarButtonItem.tintColor = .black
        }
      
        self.navigationItem.backBarButtonItem = backBarButtonItem
        if let data = dateData {
            vc.dateString = dateFormatToString(date: data, formatStyle: .yyyyMMddEaHHmm)
        } else {
            vc.dateString = dateFormatToString(date: Date(), formatStyle: .yyyyMMddEaHHmm)
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
