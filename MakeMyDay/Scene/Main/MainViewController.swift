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
    
    var pinned: Results<Dday>!{
        didSet {
            mainView.tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    var menuState = false
    
    override func loadView() {
        super.loadView()
        self.view = self.mainView
      
    }
    
    let popupView = NavTitleView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationUI()
        fetchRealm()
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        configureUI()
        setNavigationUI()
        hoverButton()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        mainView.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        mainView.tableView.register(DdayTableViewCell.self, forCellReuseIdentifier: DdayTableViewCell.reuseIdentifier)
        
    }
    
    override func setNavigationUI() {
        navigationItem.titleView = popupView
      
          let navController = parent as! UINavigationController

//        navController.navigationItem.titleView = popupView
        navController.navigationBar.topItem!.title = .none
    
//          navController.navigationBar.topItem!.titleView = popupView
        navController.navigationBar.topItem?.titleView?.isHidden = false
          navController.navigationBar.prefersLargeTitles = true

        let backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backButtonTapped))
        backBarButtonItem.tintColor = themeType().tintColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationItem.titleView?.tintColor = themeType().tintColor
        
        navigationBarAppearance.backgroundColor = themeType().backgroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
//        navigationBarAppearance.backgroundColor = themeType().backgroundColor
//        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]

        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    override func configureUI() {
        guard let date = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm) else { return }
        mainView.dateLabel.text = dateFormatToString(date: date, formatStyle: .yyyyMMddEaHHmm)

    }
    
    func hoverButton() {
        mainView.writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        mainView.scheduleWriteButton.addTarget(self, action: #selector(scheduleWriteButtonTapped), for: .touchUpInside)
        mainView.ddayWriteButton.addTarget(self, action: #selector(ddayWriteButtonTapped), for: .touchUpInside)
    }
    
    func fetchRealm() {
        
        let today = dateFormatToString(date: Date(), formatStyle: .yyyyMMdd)
        scheduleTasks = scheduleRepository.fetchFilterDateString(formatString: today)
        ddayTasks = ddayRepository.fetch()
        pinned = ddayRepository.fetchFilterPinned()
        
        mainView.tableView.reloadData()
     
    }
    
    @objc func writeButtonTapped() {
        switch menuState {
        case true:
            menuState = false
            mainView.writeButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            mainView.scheduleWriteButton.isHidden = !mainView.scheduleWriteButton.isHidden
            mainView.ddayWriteButton.isHidden = !mainView.ddayWriteButton.isHidden
        case false:
            menuState = true
            mainView.writeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            mainView.scheduleWriteButton.isHidden = !mainView.scheduleWriteButton.isHidden
            mainView.ddayWriteButton.isHidden = !mainView.ddayWriteButton.isHidden
        }
      
        
    
    }
    
    @objc func scheduleWriteButtonTapped() {
        let vc = ScheduleWriteViewController()
        vc.edit = false
        
        let today = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm)
        vc.dateData = today
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backButtonTapped() {

        navigationController?.title = nil
        navigationController?.navigationBar.topItem?.title = .none
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func ddayWriteButtonTapped() {
        let vc = DdayWriteViewController()
        vc.edit = false
        
        let today = localDate(date: Date(), formatStyle: .yyyyMMdd)
        vc.dateData = today
        
        self.navigationController?.pushViewController(vc, animated: true)
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
        switch indexPath.section {
        case 2:
            return 80
        case 4:
            return 80
        default:
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return scheduleTasks == nil ? 0 : scheduleTasks.count
        case 4:
            return pinned == nil ? 0 : pinned.count
        default:
            return 1
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.titleLabel.text = selectScript(scriptType: .hi)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if scheduleTasks.count == 0 {
                cell.titleLabel.text = selectScript(scriptType: .scheduleNil)
            } else {
                cell.titleLabel.text = selectScript(scriptType: .scheduleValue)
            }
 
            return cell
        case 2:
            guard let scheduleCell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
            scheduleCell.selectionStyle = .none
            scheduleCell.backgroundColor = .clear
            
            scheduleCell.backgroundImageView.image = themeType().bubbleLong
            
            let string = dateFormatToString(date: scheduleTasks[indexPath.row].date, formatStyle: .hhmm)
            scheduleCell.titleLabel.text = scheduleTasks[indexPath.row].title
            scheduleCell.titleLabel.textAlignment = .center
            scheduleCell.titleLabel.textColor = themeType().countTextColor
            scheduleCell.dateLabel.text = string
            scheduleCell.dateLabel.textAlignment = .center
            scheduleCell.dateLabel.textColor = .systemGray6
            
            return scheduleCell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none

            if pinned.count == 0 {
                cell.titleLabel.text = selectScript(scriptType: .ddayNil)
            } else {
                cell.titleLabel.text = selectScript(scriptType: .ddayValue)
            }

            
            return cell
        default:
            guard let ddayCell = tableView.dequeueReusableCell(withIdentifier: DdayTableViewCell.reuseIdentifier, for: indexPath) as? DdayTableViewCell else { return UITableViewCell() }
            ddayCell.selectionStyle = .none
            ddayCell.backgroundColor = .clear
            
            ddayCell.backgroundImageView.image = themeType().bubbleLong
            ddayCell.titleLabel.text = pinned[indexPath.row].title
            ddayCell.titleLabel.textAlignment = .center
            ddayCell.dateLabel.text = "\(pinned[indexPath.row].dateString)"
            ddayCell.dateLabel.textColor = .systemGray6
            
            let startDate = stringFormatToDate(string: pinned[indexPath.row].dateString, formatStyle: .yyyyMMdd)!
            let daysCount = days(from: startDate)

            ddayCell.countLabel.text = "\(daysCount) 일"
            
            return ddayCell
            
        }
       
    }
    
}
