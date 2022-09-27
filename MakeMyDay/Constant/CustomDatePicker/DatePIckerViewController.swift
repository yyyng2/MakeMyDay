//
//  ScheduleDatePickerViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/15.
//

import UIKit

protocol DatePickerDataProtocol: AnyObject {
    func updateDate(_ date: Date)
}

class DatePickerViewController: BaseViewController {
    let mainView = DatePickerView()
    
    weak var delegate: DatePickerDataProtocol?
    
    var schedule = false
    
    var date: Date? = nil
    
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
        if User.pickerType {
            mainView.datePicker.datePickerMode = .dateAndTime
        } else {
            mainView.datePicker.datePickerMode = .date
        }
    }
    
    func configureButton() {
        mainView.datePicker.addTarget(self, action: #selector(datePickerValueTapped), for: .touchUpInside)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
  
    }
 
    func configureGetsture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.mainView.backgroundView.addGestureRecognizer(tapGesture)
    }

    @objc func doneButtonTapped() {
        self.delegate?.updateDate(self.mainView.datePicker.date)
        self.dismiss(animated: true)
    }
    
    @objc func datePickerValueTapped(_ sender: UIDatePicker){
        
    }
    
    override func setConstraints() {
        mainView.datePicker.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.7)
            make.height.equalTo(self.view).multipliedBy(0.47)
        }
        mainView.doneButton.snp.makeConstraints { make in
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
