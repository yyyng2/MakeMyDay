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
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
           [unowned self] in
           let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
           panGesture.delegate = self
           panGesture.minimumNumberOfTouches = 1
           panGesture.maximumNumberOfTouches = 2
           return panGesture
       }()
    
    override func loadView() {
        super.loadView()
 
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .always
        fetchRealm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        configureButton()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        
        calendar.delegate = self
        calendar.dataSource = self
       
        self.view.addGestureRecognizer(self.scopeGesture)
        self.mainView.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
    }
    
    override internal func configure() {
        guard let todayDate = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm) else { return }
        headerDate = todayDate
        headerString = dateFormatToString(date: todayDate, formatStyle: .yyyyMMdd)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.3
        calendar.scope = .month
    }
    
    private func configureButton() {
        mainView.writeButton.addTarget(self, action: #selector(writeItemTapped), for: .touchUpInside)
        mainView.updownButton.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
    }
    
    func fetchRealm() {
        guard let date: Date = stringFormatToDate(string: headerString, formatStyle: .yyyyMMdd) else { return }
        guard let formatDate = localDate(date: date, formatStyle: .yyyyMMdd) else { return }
        let selectDate = dateFormatToString(date: formatDate, formatStyle: .yyyyMMdd)
        scheduleTasks = scheduleRepository.fetchFilterDateString(formatString: selectDate)
        
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
            vc.dateData = today
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
      
        let backBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        backBarButtonItem.tintColor = themeType().tintColor
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func deleteCell(schedule: Results<Schedule>, index: IndexPath){
        let task = scheduleTasks[index.row].objectId
        self.scheduleRepository.deleteById(id: task)
        self.fetchRealm()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.popViewController(animated: true)
    }
    
    func dateCount(date: Date) -> Int {
        let formatDate = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        let result = scheduleRepository.fetchFilterDateString(formatString: formatDate)
        return result.count
    }
    
}
extension ScheduleViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
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
    
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }

    }
    
   
    
    func moveToDate(date: Date) {
        calendar.select(date, scrollToDate: true)
        dateData = date
        headerString = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        fetchRealm()
        mainView.tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if dateCount(date: date) == 0 {
            return 0
        } else {
            return 1
        }
    }
    
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerString
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = themeType().tintColor
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
        cell.backgroundColor = themeType().foregroundColor
      
        let string = dateFormatToString(date: scheduleTasks[indexPath.row].date, formatStyle: .hhmm)
        cell.titleLabel.text = scheduleTasks[indexPath.row].title
        cell.dateLabel.text = string
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ScheduleWriteViewController()
        vc.edit = true
        vc.schedule = scheduleTasks[indexPath.row]
        vc.delegate = self
  
        let date = stringFormatToDate(string: scheduleTasks[indexPath.row].dateString, formatStyle: .yyyyMMddEaHHmm)
        vc.dateData = date

        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            
            let alert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "삭제", style: .destructive) {_ in

                self.deleteCell(schedule: self.scheduleTasks, index: indexPath)
            
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(okay)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
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
extension ScheduleViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.mainView.tableView.contentOffset.y <= -self.mainView.tableView.contentInset.top
           if shouldBegin {
               let velocity = self.scopeGesture.velocity(in: self.view)
               switch self.calendar.scope {
               case .month:
                   return velocity.y < 0
               case .week:
                   return velocity.y > 0
               default:
                   fatalError()
               }
           }
           return shouldBegin
       }
}
