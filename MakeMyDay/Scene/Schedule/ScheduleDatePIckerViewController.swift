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

class ScheduleDatePickerViewController: BaseViewController {
    let mainView = ScheduleDatePickerView()
    
    weak var delegate: DatePickerDataProtocol?
    
    let date: Date? = nil
    
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
    }
    override func configureUI() {
    
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
extension ScheduleDatePickerViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        self.dismiss(animated: false)
        return true
    }
}
