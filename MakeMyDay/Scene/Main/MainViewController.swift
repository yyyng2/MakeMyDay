//
//  ViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

import RealmSwift

class MainViewController: BaseViewController {
    
    lazy var mainView = MainView()
    
    lazy var navTitleView = NavTitleView()
    
    lazy var navBackgroundColor = [Constants.BaseColor.foreground, .systemGray6]
    
    let dateFormatter = DateFormatter()
    
    let scheduleRepository = ScheduleRepository()
    
    let ddayRepository = DdayRepository()
    
    var scheduleTasks: Results<Schedule>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var ddayTasks: Results<Dday>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.mainView
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func viewDidLoad() {
        configureUI()
        setNavigationUI()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        mainView.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        
        print(Date())
        
    }
    
    override func setNavigationUI() {
        
        navigationItem.titleView = navTitleView
        
        if User.themeType {
            navigationBarAppearance.backgroundColor = .systemGray6
        } else {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
        }
     
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    override func configureUI() {
        guard let date = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm) else { return }
        mainView.dateLabel.text = dateFormatToString(date: date, formatStyle: .yyyyMMddEaHHmm)
    }
    
    @objc func settingButtonTapped() {
        print(#function)
        let vc = SettingViewController()
        transition(vc, transitionStyle: .push)
    }
    
    func fetchRealm() {
        guard let todayDate = localDate(date: Date(), formatStyle: .yyyyMMdd) else { return }
        scheduleTasks = scheduleRepository.fetchFilterDate(date: todayDate)
        ddayTasks = ddayRepository.fetchFilterDate(date: todayDate)
        
        mainView.tableView.reloadData()
     
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else if indexPath.section == 1 {
            return 60
        } else if indexPath.section == 3 {
            return 60
        }
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return scheduleTasks == nil ? 0 : scheduleTasks.count
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return ddayTasks == nil ? 0 : ddayTasks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none

            cell.titleLabel.text = selectScript(scriptType: .hi)
            
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if scheduleTasks.count == 0 {
                cell.titleLabel.text = selectScript(scriptType: .scheduleNil)
            } else {
                cell.titleLabel.text = selectScript(scriptType: .scheduleValue)
            }

 
            return cell
            
        } else if indexPath.section == 2 {
            
            guard let scheduleCell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
            scheduleCell.selectionStyle = .none
            scheduleCell.backgroundColor = .clear
            
            if User.themeType {
                scheduleCell.backgroundImageView.image = selectImage(imageType: .bubbleBlackLong)
            } else {
                scheduleCell.backgroundImageView.image = selectImage(imageType: .bubbleWhiteLong)
            }
            
            let string = dateFormatToString(date: scheduleTasks[indexPath.row].date, formatStyle: .hhmm)
            scheduleCell.titleLabel.text = scheduleTasks[indexPath.row].title
            scheduleCell.titleLabel.textAlignment = .center
            scheduleCell.dateLabel.text = string
            scheduleCell.dateLabel.textAlignment = .center
            
            return scheduleCell
            
        } else if indexPath.section == 3 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none

            if ddayTasks.count == 0 {
                cell.titleLabel.text = selectScript(scriptType: .ddayNil)
            } else {
                cell.titleLabel.text = selectScript(scriptType: .ddayValue)
            }

            
            return cell
            
        } else if indexPath.section == 4 {
            
            guard let ddayCell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
            ddayCell.selectionStyle = .none
            ddayCell.backgroundColor = .clear
            
            if User.themeType {
                ddayCell.backgroundImageView.image = selectImage(imageType: .bubbleBlackLong)
            } else {
                ddayCell.backgroundImageView.image = selectImage(imageType: .bubbleWhiteLong)
            }
//            ddayCell.titleLabel.text = ddayTasks[indexPath.row].title
//            ddayCell.dateLabel.text = "\(ddayTasks[indexPath.row].date)"
            return ddayCell
            
        }
       
        return UITableViewCell()
       
    }
    
}
