//
//  ScheduleWriteViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/15.
//

import UIKit

class ScheduleWriteViewController: BaseViewController {
    let mainView = ScheduleWriteView()
    
    let scheduleRepository = ScheduleRepository()
    
    var edit = false
    
    lazy var dateString = ""
    
    weak var delegate: DatePickerDataProtocol?
    
    var dateData: Date?
    
    var schedule: Schedule?
    
    var titleText = ""
    var contentText = ""
    
    let textViewPlaceHolder = "텍스트를 입력하세요. 날짜도 변경가능합니다!"
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        setNavigationItem()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        edit = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func configure() {
        
        if edit == true {
            guard let realmDate = schedule?.date else { return }
            let date = dateFormatToString(date: realmDate, formatStyle: .yyyyMMddEaHHmm)
            mainView.dateLabel.text = date
            
            guard let title = schedule?.title else { return }
            guard let content = schedule?.content else { return }
            
            mainView.scheduleTextView.text = "\(title)\n\(content)"
        } else {
            if let data = dateData {
                mainView.dateLabel.text = dateFormatToString(date: data, formatStyle: .yyyyMMddEaHHmm)
            } else {
                mainView.dateLabel.text = dateFormatToString(date: Date(), formatStyle: .yyyyMMddEaHHmm)
            }
        }
        
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    func setNavigationItem() {
        let doneButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(doneButtonTapped))
        let shareButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        doneButtonItem.tintColor = themeType().tintColor
        shareButtonItem.tintColor = themeType().tintColor
        
        self.navigationItem.rightBarButtonItems = [doneButtonItem, shareButtonItem]
    }
    
    func configureButton() {
        mainView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
    }
    
    @objc func dateButtonTapped() {
        let vc = DatePickerViewController()
        vc.delegate = self
        guard let text = mainView.dateLabel.text else { return }
        vc.selectDate = stringFormatToDate(string: text, formatStyle: .yyyyMMddEaHHmm)
        User.pickerType = true
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func doneButtonTapped() {
        saveFunction()
        self.delegate?.updateDate(schedule!.date)
 
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveFunction(){
        print(#function)
        guard let date = dateData else { return }
        guard let text = mainView.dateLabel.text else { return }
        
        guard let data = localDate(date: date, formatStyle: .yyyyMMddEaHHmm) else { return }
        
        let content = mainView.scheduleTextView.text!
        let array = content.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == "\n"})
        
        if edit == true {
            let id = schedule?.objectId
      
            if array.count == 2 {
                titleText = String(array[0])
                contentText = String(array[1])

                let task = Schedule(title: titleText, content: contentText, date: data, dateString: text)
                scheduleRepository.updateRecord(id: id!, record: task)
            } else {
                titleText = String(array[0])
                let task = Schedule(title: titleText, content: "", date: data, dateString: text)
                scheduleRepository.updateRecord(id: id!, record: task)
            }
        } else {
           
            if array.count == 2 {
                titleText = String(array[0])
                contentText = String(array[1])
                let task = Schedule(title: titleText, content: contentText, date: data, dateString: text)
                scheduleRepository.addRecord(record: task)
            } else {
                titleText = String(array[0])
                let task = Schedule(title: titleText, content: "", date: data, dateString: text)
                scheduleRepository.addRecord(record: task)
            }
        }
        
        scheduleRepository.deleteEmptyRecord()
        
        edit = false
        let vc = ScheduleViewController()
        vc.fetchRealm()
    }
    
    @objc func shareButtonTapped(){
        let trimString = mainView.scheduleTextView.text!.filter {!"\n".contains($0)}
        let textToShare: String = trimString

        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
            // 성공했을 때 작업
                self.showAlert(title: "", message: "전달에 성공했습니다.", buttonTitle: "확인")
           }  else  {
            // 실패했을 때 작업
               self.showAlert(title: "", message: "전달에 실패했습니다.", buttonTitle: "확인")
           }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}


extension ScheduleWriteViewController: DatePickerDataProtocol {
    func updateDate(_ date: Date) {
        dateData = date
        let data = dateFormatToString(date: date, formatStyle: .yyyyMMddEaHHmm)
        mainView.dateLabel.text = data
    }
    
    
}
