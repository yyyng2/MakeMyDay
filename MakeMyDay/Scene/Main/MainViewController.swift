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
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationUI()
        fetchRealm()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        configure()
        setNavigationUI()
        hoverButton()

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainProfileTableViewCell.self, forCellReuseIdentifier: MainProfileTableViewCell.reuseIdentifier)
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        mainView.tableView.register(MainScheduleTableViewCell.self, forCellReuseIdentifier: MainScheduleTableViewCell.reuseIdentifier)
        mainView.tableView.register(MainDdayTableViewCell.self, forCellReuseIdentifier: MainDdayTableViewCell.reuseIdentifier)
        
    }
    
    override func setNavigationUI() {
      
          let navController = parent as! UINavigationController

        navController.navigationBar.topItem!.title = "Home"

          navController.navigationBar.prefersLargeTitles = true
     
        let backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backButtonTapped))
        backBarButtonItem.tintColor = themeType().tintColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationItem.titleView?.tintColor = themeType().tintColor
        
        navigationBarAppearance.backgroundColor = themeType().backgroundColor
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]

        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    override func configure() {
        mainView.dateLabel.text = Date().formattedToStringYyyymmddeahhmm()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3:
            return 60
        case 6:
            return 60
        default:
            return 45
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return scheduleTasks == nil ? 0 : scheduleTasks.count
        case 6:
            return pinned == nil ? 0 : pinned.count
        default:
            return 1
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = ImageFileManager.shared.profileImageName
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainProfileTableViewCell.reuseIdentifier, for: indexPath) as? MainProfileTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if User.profileImageBool {
                if let image: UIImage = ImageFileManager.shared.getSavedImage(named: name) {
                    cell.profileView.image = image
                }
            } else {
                cell.profileView.image = themeType().profileImage
            }
            
            if User.profileNameBool {
                cell.profileLabel.text = User.profileName
            } else {
                cell.profileLabel.text = "D"
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.titleLabel.text = selectScript(scriptType: .hi)
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if scheduleTasks.count == 0 {
                cell.titleLabel.text = selectScript(scriptType: .scheduleNil)
            } else {
                cell.titleLabel.text = selectScript(scriptType: .scheduleValue)
            }
 
            return cell
        case 3:
            guard let scheduleCell = tableView.dequeueReusableCell(withIdentifier: MainScheduleTableViewCell.reuseIdentifier, for: indexPath) as? MainScheduleTableViewCell else { return UITableViewCell() }
            scheduleCell.selectionStyle = .none
            scheduleCell.backgroundColor = .clear
            
            scheduleCell.backgroundImageView.image = themeType().bubbleLong
            
            let string = dateFormatToString(date: scheduleTasks[indexPath.row].date, formatStyle: .hhmm)
            scheduleCell.titleLabel.text = scheduleTasks[indexPath.row].title
            scheduleCell.titleLabel.textColor = themeType().countTextColor
            scheduleCell.dateLabel.text = string
            scheduleCell.dateLabel.textAlignment = .center
            scheduleCell.dateLabel.textColor = .systemGray6
            
            return scheduleCell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainProfileTableViewCell.reuseIdentifier, for: indexPath) as? MainProfileTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if User.profileImageBool {
                if let image: UIImage = ImageFileManager.shared.getSavedImage(named: name) {
                    cell.profileView.image = image
                }
            } else {
                cell.profileView.image = themeType().profileImage
            }
            
            if User.profileNameBool {
                cell.profileLabel.text = User.profileName
            } else {
                cell.profileLabel.text = "D"
            }
            
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none

            if pinned.count == 0 {
                cell.titleLabel.text = selectScript(scriptType: .ddayNil)
            } else {
                cell.titleLabel.text = selectScript(scriptType: .ddayValue)
            }

            
            return cell
        default:
            guard let ddayCell = tableView.dequeueReusableCell(withIdentifier: MainDdayTableViewCell.reuseIdentifier, for: indexPath) as? MainDdayTableViewCell else { return UITableViewCell() }
            ddayCell.selectionStyle = .none
            ddayCell.backgroundColor = .clear
            
            ddayCell.backgroundImageView.image = themeType().bubbleLong
            ddayCell.titleLabel.text = pinned[indexPath.row].title
            ddayCell.dateLabel.text = "\(pinned[indexPath.row].dateString)"
            ddayCell.dateLabel.textColor = .systemGray6
            
            let startDate = stringFormatToDate(string: pinned[indexPath.row].dateString, formatStyle: .yyyyMMdd)!
            let daysCount = days(from: startDate)

            ddayCell.countLabel.text = "\(daysCount) 일"
            
            return ddayCell
            
        }
       
    }
    
}
