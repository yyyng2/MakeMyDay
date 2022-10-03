//
//  ScheduleDatePickerViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/15.
//

import UIKit

protocol DatePickerDateNumProtocol: AnyObject {
    func updateDateNum(_ date: Date, _ num: Int, _ bool: Bool)
}
protocol DatePickerDateProtocol: AnyObject {
    func updateDate(_ date: Date)
}

class DatePickerViewController: BaseViewController {
    let mainView = DatePickerView()
    
    weak var dateDelegate: DatePickerDateProtocol?
    
    weak var dateNumDelegate: DatePickerDateNumProtocol?
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var schedule = false
    
    var date: Date? = nil
    
    var alarmBool = false
    
    var dayNum = 0
    
    var selectDate: Date?
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        //configureGetsture()
        configureButton()
        
        configureDatePicker()
        
    }
    
    func configureDatePicker() {
        mainView.datePicker.locale = Locale.current
        mainView.datePicker.calendar.locale = Locale.current
        mainView.datePicker.timeZone = TimeZone.autoupdatingCurrent
        
        guard let date = selectDate else { return }
        mainView.datePicker.setDate(date, animated: true)
    }
    
    override func configure() {
        switch User.pickerType {
        case 0:
            mainView.datePicker.datePickerMode = .dateAndTime
        case 1:
            mainView.datePicker.datePickerMode = .date
        default:
            mainView.datePicker.datePickerMode = .time
            mainView.datePicker.snp.makeConstraints { make in
                make.center.equalTo(mainView.backgroundView)
            }
            
            mainView.pickerLabel.isHidden = false
            mainView.alarmLabel.isHidden = false
            mainView.alarmSwitchButton.isHidden = false
            mainView.dayLabel.isHidden = false
            mainView.alarmSwitchButton.isOn = alarmBool
        }
    }
    
    func configureButton() {
        mainView.datePicker.addTarget(self, action: #selector(datePickerValueTapped), for: .touchUpInside)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.alarmSwitchButton.addTarget(self, action: #selector(userRequest), for: .touchUpInside)
  
    }
 
    func configureGetsture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.mainView.backgroundView.addGestureRecognizer(tapGesture)
    }

    @objc func doneButtonTapped() {
        self.dateDelegate?.updateDate(self.mainView.datePicker.date)
        self.dateNumDelegate?.updateDateNum(self.mainView.datePicker.date, self.dayNum, self.mainView.alarmSwitchButton.isOn)
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func datePickerValueTapped(_ sender: UIDatePicker){
        
    }
    
    @objc func userRequest() {
                
            let options: UNAuthorizationOptions = [.alert, .sound]
                
            notificationCenter.requestAuthorization(options: options) {
                    (status, error) in
                if status {
                    
                } else {
                    DispatchQueue.main.async {
                        self.mainView.alarmSwitchButton.isOn = false
                        let alert = UIAlertController(title: "", message: "알림 설정이 꺼져있습니다. 설정화면으로 이동하시겠습니까?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { UIAlertAction in
                            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }))
                        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                        self.present(alert, animated: true)
                    }
               
                }
                        print("granted NotificationCenter : \(status)")
                }
    }
    
    override func setConstraints() {
        mainView.pickerBackground.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.7)
            make.height.equalTo(self.view).multipliedBy(0.47)
        }
        mainView.datePicker.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.7)
            make.height.equalTo(self.view).multipliedBy(0.47)
        }
        mainView.buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(mainView.datePicker.snp.bottom)
            make.centerX.equalTo(self.view)
            make.width.equalTo(mainView.datePicker.snp.width)
            make.height.equalTo(self.view).multipliedBy(0.1)
        }
    }
        
    
}
extension DatePickerViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        self.dismiss(animated: false)
        return true
    }
}
