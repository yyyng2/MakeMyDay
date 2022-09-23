//
//  SettingViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class SettingViewController: BaseViewController{
    
    lazy var mainView = SettingView()
    
    let scheduleRepository = ScheduleRepository()
    
    let ddayRepository = DdayRepository()
    
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
        let backBarButtonItem = UIBarButtonItem(title: "D-day", style: .plain, target: self, action: #selector(backButtonTapped))
        backBarButtonItem.tintColor = themeType().tintColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationController?.navigationBar.prefersLargeTitles = true
       
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func resetApp() {
        let warning = UIAlertController(title: "경고", message: "일정과 디데이 모두 초기화됩니다", preferredStyle: .alert)
        warning.addAction(UIAlertAction(title: "초기화", style: .destructive, handler: {action in
            self.scheduleRepository.deleteAll()
            self.ddayRepository.deleteAll()
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let viewController = PageViewController()
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewController)
                sceneDelegate?.window?.makeKeyAndVisible()
        }))
        warning.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(warning, animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.popViewController(animated: true)
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
        case 0:
            let vc = AppInfoViewController()
            navigationController?.pushViewController(vc, animated: true)
//       case 1:
           
        case 2:
            let vc = ThemeViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case 3:
            resetApp()
        case 4:
            let vc = LicenseViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
