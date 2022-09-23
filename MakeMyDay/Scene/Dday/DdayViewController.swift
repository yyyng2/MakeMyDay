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
    
    let ddayRepository = DdayRepository()
    
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
    
    var unPinned: Results<Dday>!{
        didSet {
            mainView.tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    func fetchRealm() {
        ddayTasks = ddayRepository.fetch()
        pinned = ddayRepository.fetchFilterPinned()
        unPinned = ddayRepository.fetchFilterUnPinned()
        
        mainView.tableView.reloadData()
    }
    
    var headerString = ""
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(DdayTableViewCell.self, forCellReuseIdentifier: DdayTableViewCell.reuseIdentifier)
        
    }
    
    override func configureUI() {
        guard let todayDate = localDate(date: Date(), formatStyle: .yyyyMMddEaHHmm) else { return }
        headerString = dateFormatToString(date: todayDate, formatStyle: .yyyyMMdd)
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
      

        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        
        let backBarButtonItem = UIBarButtonItem(title: "D-day", style: .plain, target: self, action: #selector(backButtonTapped))
        backBarButtonItem.tintColor = themeType().tintColor
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func writeItemTapped() {
        let vc = DdayWriteViewController()
        vc.edit = false
        
        let today = localDate(date: Date(), formatStyle: .yyyyMMdd)
        vc.dateData = today

        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deletePinnedCell(dday: Results<Dday>, index: IndexPath){
        let task = pinned[index.row].objectId
        self.ddayRepository.deleteById(id: task)
        self.fetchRealm()
        mainView.tableView.reloadData()
    }
    
    func deleteUnpinnedCell(dday: Results<Dday>, index: IndexPath){
        let task = unPinned[index.row].objectId
        self.ddayRepository.deleteById(id: task)
        self.fetchRealm()
        mainView.tableView.reloadData()
    }
    
}

extension DdayViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return pinned.count <= 0 ? "" : "즐겨찾는 D-day"
        default:
            if pinned.count > 0 {
                return unPinned.count <= 0 ? "" : "D-day"
            } else {
                return unPinned.count <= 0 ? "" : "Swipe 즐겨찾기로\n메인화면에서 확인해 보세요!"
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = TableHeaderView()
            headerView.sectionLabel.text = headerString
            headerView.writeButton.addTarget(self, action: #selector(writeItemTapped), for: .touchUpInside)

            return headerView
        } else {
            return nil
        }
       
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
        switch section {
        case 1:
            return pinned == nil ? 0 : pinned.count
        case 2:
            return unPinned == nil ? 0 : unPinned.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DdayTableViewCell.reuseIdentifier, for: indexPath) as? DdayTableViewCell else { return UITableViewCell() }
        switch indexPath.section {
        case 1:
            let startDate = stringFormatToDate(string: pinned[indexPath.row].dateString, formatStyle: .yyyyMMdd)!
            let daysCount =  days(from: startDate)
            
            cell.countLabel.text = "\(daysCount) 일"
            cell.titleLabel.text = pinned[indexPath.row].title
            cell.dateLabel.text = pinned[indexPath.row].dateString
      
    
            return cell
        case 2:
            let startDate = stringFormatToDate(string: unPinned[indexPath.row].dateString, formatStyle: .yyyyMMdd)!
            let daysCount =  days(from: startDate)

            cell.countLabel.text = "\(daysCount) 일"
            
            cell.titleLabel.text = unPinned[indexPath.row].title
            cell.dateLabel.text = unPinned[indexPath.row].dateString

            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DdayWriteViewController()
        
        
        switch indexPath.section {
        case 1:
            vc.dday = pinned[indexPath.row]
        default:
            vc.dday = unPinned[indexPath.row]
        }
        vc.edit = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            
            let alert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "삭제", style: .destructive) {_ in
                switch indexPath.section {
                case 1:
                    self.deletePinnedCell(dday: self.pinned, index: indexPath)
                default:
                    self.deleteUnpinnedCell(dday: self.unPinned, index: indexPath)
                }
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(okay)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 1:
            
            let pin = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
                self.ddayRepository.updatePin(record: self.pinned[indexPath.row])
                self.fetchRealm()
            }
            
            let image = self.pinned[indexPath.row].pin ? "star.fill" : "star"
            pin.image = UIImage(systemName: image)
            pin.backgroundColor = .orange
            
            return UISwipeActionsConfiguration(actions: [pin])
            
        default:
            
            let pin = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
                if self.pinned.count < 5 {
                    self.ddayRepository.updatePin(record: self.unPinned[indexPath.row])
                    self.fetchRealm()
                } else {
                    self.showAlert(title: "!", message: "즐겨찾기는 5개를 넘을 수 없습니다.", buttonTitle: "확인")
                    return
                }
                
                self.fetchRealm()
            }
            let image = self.unPinned[indexPath.row].pin ? "star.fill" : "star"
            pin.image = UIImage(systemName: image)
            pin.backgroundColor = .orange
            
            return UISwipeActionsConfiguration(actions: [pin])
            
        }
    }
    
}
