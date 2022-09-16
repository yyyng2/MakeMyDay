//
//  UIViewController+Extension.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

extension UIViewController{
    enum FormatStyle{
        case yyyyMMddEaHHmm
        case yyyyMMdd
        case hhmm
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func dateFormatToString(date: Date, formatStyle: FormatStyle = .yyyyMMddEaHHmm) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        switch formatStyle {
        case .yyyyMMddEaHHmm:
           dateFormatter.dateFormat = "yyyy. MM. dd (E) a hh:mm"
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .hhmm:
            dateFormatter.dateFormat = "hh:mm"
        }
        
        let string = dateFormatter.string(from: date)
        return string
    }

}
