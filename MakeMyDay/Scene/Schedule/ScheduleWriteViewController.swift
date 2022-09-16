//
//  ScheduleWriteViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/15.
//

import UIKit

class ScheduleWriteViewController: BaseViewController {
    let mainView = ScheduleWriteView()
    
    lazy var dateString = ""
    
    weak var delegate: DatePickerDataProtocol?
    
    var dateData = Date()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        saveFunction()
    }
    
    override func configureUI() {
        mainView.dateLabel.text = dateString
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false
        if themeType {
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
        let doneButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
        let shareButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        
        if themeType {
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
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func doneButtonTapped() {
   
        self.delegate?.updateDate(dateData)
 
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveFunction() {
        
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
