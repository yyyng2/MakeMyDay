//
//  ViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

class MainViewController: BaseViewController {
    
    lazy var mainView = MainView()
    
    lazy var navTitleView = NavTitleView()
    
    lazy var navBackgroundColor = [Constants.BaseColor.foreground, .systemGray6]
    
    let dateFormatter = DateFormatter()
    
    let textArray: [String] = ["안녕하세요. :D", "오늘의 일정을 알려드릴게요.", "일정을 추가해보세요.", "오늘 기준 디데이입니다.", "디데이를 추가해보세요."]
    
    override func loadView() {
        super.loadView()
        self.view = self.mainView
      
        
        // 첫번째 앱 실행인지 확인
        if UserDefaultsHelper.standard.first == false {
            //마지막에 주석 해제할 것
//            UserDefaultsHelper.standard.first = true
            
//            let viewController = PageViewController()
//            viewController.modalPresentationStyle = .fullScreen
//            present(viewController, animated: true)
        }
        
      
    }
    
    override func viewDidLoad() {
        configureUI()
        setNavigationUI()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        mainView.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
    }
    
    override func setNavigationUI() {
        
        navigationItem.titleView = navTitleView
        
        if themeType {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foreground
        } else {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
        }
     
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    override func configureUI() {
        mainView.dateLabel.text = dateFormatToString(date: Date(), formatStyle: .yyyyMMddEaHHmm)
    }
    
    @objc func settingButtonTapped(){
        print(#function)
        let vc = SettingViewController()
        transition(vc, transitionStyle: .push)
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
        }
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return 1
        } else if section == 2{
            return 10
        }
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            if themeType {
                cell.backgroundImageView.image = UIImage(named: "bubble_black_short")
            } else {
                cell.backgroundImageView.image = UIImage(named: "bubble_white_short")
            }
         
            cell.titleLabel.text = textArray[0]
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            if themeType {
                cell.backgroundImageView.image = UIImage(named: "bubble_black_long")
            } else {
                cell.backgroundImageView.image = UIImage(named: "bubble_white_long")
            }
            cell.titleLabel.text = textArray[1]
            return cell
        } else if indexPath.section == 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            if themeType {
                cell.backgroundImageView.image = UIImage(named: "bubble_black_long")
            } else {
                cell.backgroundImageView.image = UIImage(named: "bubble_white_long")
            }
            cell.titleLabel.text = "Test"
            cell.dateLabel.text = "2022-02-22"
            return cell
        }
       
        return UITableViewCell()
       
    }
    
}
