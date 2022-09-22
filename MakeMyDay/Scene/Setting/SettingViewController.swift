//
//  SettingViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class SettingViewController: BaseViewController{
    
    lazy var mainView = SettingView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
    }
    
    override func setNavigationUI() {
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationController?.navigationBar.prefersLargeTitles = true
       
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
    
        cell.titleLabel.text = settingMenuArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
//        case 0:
//
//        case 1:
//        case 2:
//        case 3:
        case 4:
            let vc = LicenseViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
