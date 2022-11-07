//
//  LicenseViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class LicenseViewController: BaseViewController {
    let mainView = LicenseView()
    
    let license = LicenseInfo()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(LicenseTableViewCell.self, forCellReuseIdentifier: LicenseTableViewCell.reuseIdentifier)
    }
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
      
        let backBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        backBarButtonItem.tintColor = themeType().tintColor
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    @objc func backButtonTapped() {

        self.navigationController?.popViewController(animated: true)
    }
    
}
extension LicenseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return license.license.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LicenseTableViewCell.reuseIdentifier, for: indexPath) as? LicenseTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = license.license[indexPath.row].licenseName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = LicenseDetailViewController()
        vc.licenseDescription = license.license[indexPath.row].licenseDescription
        navigationController?.pushViewController(vc, animated: true)
    }
}
