//
//  DdayWriteViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class DdayWriteViewController: BaseViewController{
    let mainView = DdayWriteView()
    
    let ddayRepository = DdayRepository()
    
    weak var delegate: DatePickerDateProtocol?
    
    var edit = false

    var dateData: Date?
    
    var dday: Dday?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureButton()
        setNavigationItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        edit = false
    }
    
    override func configure() {
        if edit == true {
            mainView.dateLabel.text = dday?.dateString
            mainView.titleTextField.text = dday?.title
            mainView.dayPlusSwitchButton.isOn = dday!.dayPlus
        } else {
            mainView.dateLabel.text = dateFormatToString(date: Date(), formatStyle: .yyyyMMdd)
        }
       
    }
    
    func configureButton() {
        mainView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    func setNavigationItem() {
        let doneButtonItem = UIBarButtonItem(title: "save".localized, style: .plain, target: self, action: #selector(doneButtonTapped))
        doneButtonItem.tintColor = themeType().tintColor

        
        self.navigationItem.rightBarButtonItems = [doneButtonItem]
    }
    
    @objc func doneButtonTapped() {
        saveFunction()
        self.delegate?.updateDate(dday!.date)

        self.navigationController?.popViewController(animated: true)
    }
    
    func saveFunction(){

        guard let text = mainView.dateLabel.text else { return }

        guard let title = mainView.titleTextField.text else { return }

        let dayPlus = mainView.dayPlusSwitchButton.isOn

        if edit == true {
            dateData = dday?.date
            guard let data = localDate(date: dateData!, formatStyle: .yyyyMMdd) else { return }
            let id = dday?.objectId
            let task = Dday(title: title, date: data, dateString: text, dayPlus: dayPlus)
            ddayRepository.updateRecord(id: id!, record: task)
            
        } else {
            guard let date = dateData else { return }
            guard let data = localDate(date: date, formatStyle: .yyyyMMdd) else { return }
            let task = Dday(title: title, date: data, dateString: text, dayPlus: dayPlus)
            ddayRepository.addRecord(record: task)
     
         
        }
        
        ddayRepository.deleteEmptyRecord()
        
        edit = false
        let vc = DdayViewController()
        vc.fetchRealm()
    }
    
    @objc func dateButtonTapped() {
        let vc = DatePickerViewController()
        vc.dateDelegate = self
        guard let text = mainView.dateLabel.text else { return }
        vc.selectDate = stringFormatToDate(string: text, formatStyle: .yyyyMMdd)
        User.pickerType = 1
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

}
extension DdayWriteViewController: DatePickerDateProtocol {
    func updateDate(_ date: Date) {
        dateData = date
        let data = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        mainView.dateLabel.text = data
    }
}
