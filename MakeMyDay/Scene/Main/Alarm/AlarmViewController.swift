//
//  AlarmViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/03.
//

import UIKit

class AlarmViewController: BaseViewController {
    let mainView = AlarmView()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    var days = DayInfo()
    
    var time = "00:00"
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SetAlarmTableViewCell.self, forCellReuseIdentifier: SetAlarmTableViewCell.reuseIdentifier)
        
        setNavigationUI()
    }
    
    override func setNavigationUI() {
        title = "notifications".localized
    }
    
    func setLocalNotification(day: Int, hour: Int, minute: Int, id: Int) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Make My Day"
        notificationContent.body = "notificationsTitle".localized
        notificationContent.sound = .default
        switch id {
        case 1:
            notificationContent.subtitle = "notificationsSun".localized
        case 2:
            notificationContent.subtitle = "notificationsMon".localized
        case 3:
            notificationContent.subtitle = "notificationsTue".localized
        case 4:
            notificationContent.subtitle = "notificationsWed".localized
        case 5:
            notificationContent.subtitle = "notificationsThu".localized
        case 6:
            notificationContent.subtitle = "notificationsFri".localized
        case 7:
            notificationContent.subtitle = "notificationsSat".localized
        default:
            notificationContent.subtitle = ""
        }
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let idString = "\(id)"
        
        let request = UNNotificationRequest(identifier: idString, content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request)
    }
    
    func deleteLocalNotification(id: Int) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(id)"])
    }

}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SetAlarmTableViewCell.reuseIdentifier, for: indexPath) as? SetAlarmTableViewCell else { return UITableViewCell() }
        cell.dayLabel.text = days.week[indexPath.row].dayName
        cell.timeLabel.text = days.week[indexPath.row].dayAlarmTime
        
        switch days.week[indexPath.row].dayAlarm {
        case true:
            cell.statusLabel.text = "notificationsStatusON".localized
            cell.statusLabel.textColor = .systemMint
        case false:
            cell.statusLabel.text = "notificationsStatusOff".localized
            cell.statusLabel.textColor = .lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DatePickerViewController()
        vc.dateNumDelegate = self
        User.pickerType = 2
        vc.mainView.dayLabel.text = days.week[indexPath.row].dayName
        vc.alarmBool = days.week[indexPath.row].dayAlarm
        vc.dayNum = days.week[indexPath.row].dayNum
        vc.selectDate = days.week[indexPath.row].dayAlarmTime.stringFormatToDateAHhmm()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}
extension AlarmViewController: DatePickerDateNumProtocol {
    func updateDateNum(_ date: Date, _ num: Int, _ bool: Bool) {
        let data = date.dateFormattedToStringAhhmm()
        switch num {
        case 1:
            User.alarmSun = bool
            User.alarmSunTime = data
        case 2:
            User.alarmMon = bool
            User.alarmMonTime = data
        case 3:
            User.alarmTue = bool
            User.alarmTueTime = data
        case 4:
            User.alarmWed = bool
            User.alarmWedTime = data
        case 5:
            User.alarmThu = bool
            User.alarmThuTime = data
        case 6:
            User.alarmFri = bool
            User.alarmFriTime = data
        default:
            User.alarmSat = bool
            User.alarmSatTime = data
        }
        switch bool {
        case true:
            setLocalNotification(day: num, hour: date.dateFormattedToIntHh(), minute: date.dateFormattedToIntMm(), id: num)
        case false:
            deleteLocalNotification(id: num)
        }
      
        
        days = DayInfo()
        mainView.tableView.reloadData()
    }
}
