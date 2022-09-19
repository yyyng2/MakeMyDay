//
//  DdayViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

import RealmSwift

class DdayViewController: BaseViewController{
    lazy var mainView = DdayView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(DdayTableViewCell.self, forCellReuseIdentifier: DdayTableViewCell.reuseIdentifier)
    }
    
    override func setNavigationUI() {
        if User.themeType {
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

extension DdayViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "고정된 D-day"
        } else {
            return "D-day"
        }
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
        if section == 0{
            return 3
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DdayTableViewCell.reuseIdentifier, for: indexPath) as? DdayTableViewCell else { return UITableViewCell() }
      
        cell.titleLabel.text = "test"
        return cell
    }
}
