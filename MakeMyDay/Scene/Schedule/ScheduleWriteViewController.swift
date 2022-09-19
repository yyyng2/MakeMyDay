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
    
    override func configureUI() {
        
        if edit == true{
            guard let realmDate = schedule?.date else { return }
            let date = dateFormatToString(date: realmDate, formatStyle: .yyyyMMddEaHHmm)
            mainView.dateLabel.text = date
            mainView.scheduleTextView.text = schedule?.allText
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
        
        if User.themeType {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foreground
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func setNavigationItem() {
        let doneButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(doneButtonTapped))
        let shareButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        
        if User.themeType {
            doneButtonItem.tintColor = .white
            shareButtonItem.tintColor = .white
        } else {
            doneButtonItem.tintColor = .black
            shareButtonItem.tintColor = .black
        }
        
        self.navigationItem.rightBarButtonItems = [doneButtonItem, shareButtonItem]
    }
    
    func configureButton() {
        mainView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
    }
    
    @objc func dateButtonTapped() {
        let vc = ScheduleDatePickerViewController()
        vc.delegate = self
        guard let text = mainView.dateLabel.text else { return }
        vc.selectDate = stringFormatToDate(string: text, formatStyle: .yyyyMMddEaHHmm)
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
        guard let dateString = stringFormatToDate(string: text, formatStyle: .yyyyMMddEaHHmm) else { return }
        //let stringDate = dateFormatToString(date: dateString, formatStyle: .yyyyMMddEaHHmm)
        
        guard let data = localDate(date: date, formatStyle: .yyyyMMddEaHHmm) else { return }

        if edit == true {
            let id = schedule?.objectId
            let content = mainView.scheduleTextView.text!
            let array = content.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == "\n"})


            if array.count == 2 {
                titleText = String(array[0])
                contentText = String(array[1])

                let task = Schedule(allText: content, title: titleText, content: contentText, date: data, dateString: text)
                scheduleRepository.updateRecord(id: id!, record: task)
            } else {
                titleText = String(array[0])
                let task = Schedule(allText: content, title: titleText, content: "추가 텍스트 없음", date: data, dateString: text)
                scheduleRepository.updateRecord(id: id!, record: task)
            }
        } else {
            let content = mainView.scheduleTextView.text!
            print(content)
            let array = content.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == "\n"})
            if array.count == 2 {
                titleText = String(array[0])
                contentText = String(array[1])
                let task = Schedule(allText: content, title: titleText, content: contentText, date: data, dateString: text)
                scheduleRepository.addRecord(record: task)
            } else {
                titleText = String(array[0])
                let task = Schedule(allText: content, title: titleText, content: "추가 텍스트 없음", date: data, dateString: text)
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
