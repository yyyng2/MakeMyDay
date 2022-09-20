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
    
    weak var delegate: DatePickerDataProtocol?
    
    var edit = false

    var dateData: Date?
    
    var dday: Dday?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        setNavigationItem()
    }
    
    override func configureUI() {
        mainView.dateLabel.text = dateFormatToString(date: Date(), formatStyle: .yyyyMMdd)
    }
    
    func configureButton() {
        mainView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
//        if User.themeType {
//            navigationBarAppearance.backgroundColor = Constants.BaseColor.foreground
//            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        } else {
//            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
//            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        }
        
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func setNavigationItem() {
        let doneButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(doneButtonTapped))
        doneButtonItem.tintColor = themeType().tintColor
//        if User.themeType {
//            doneButtonItem.tintColor = .white
//        } else {
//            doneButtonItem.tintColor = .black
//        }
        
        self.navigationItem.rightBarButtonItems = [doneButtonItem]
    }
    
    @objc func doneButtonTapped() {
        saveFunction()
        self.delegate?.updateDate(dday!.date)
 
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveFunction(){
        print(#function)
        guard let date = dateData else { return }
        guard let text = mainView.dateLabel.text else { return }
        
        guard let data = localDate(date: date, formatStyle: .yyyyMMddEaHHmm) else { return }
        
        guard let title = mainView.titleTextField.text else { return }

        let task = Dday(title: title, date: data, dateString: text)

        if edit == true {
            let id = dday?.objectId
         
            ddayRepository.updateRecord(id: id!, record: task)
         
        } else {
 
            ddayRepository.addRecord(record: task)
     
         
        }
        
        ddayRepository.deleteEmptyRecord()
        
        edit = false
        let vc = DdayViewController()
        vc.fetchRealm()
    }
    
    @objc func dateButtonTapped() {
        let vc = DatePickerViewController()
        vc.delegate = self
        guard let text = mainView.dateLabel.text else { return }
        vc.selectDate = stringFormatToDate(string: text, formatStyle: .yyyyMMdd)
        User.pickerType = false
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
extension DdayWriteViewController: DatePickerDataProtocol {
    func updateDate(_ date: Date) {
        dateData = date
        let data = dateFormatToString(date: date, formatStyle: .yyyyMMdd)
        mainView.dateLabel.text = data
    }
}
