//
//  UIViewController+Extension.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

extension UIViewController {
    
    enum FormatStyle {
        case yyyyMMddEaHHmm
        case yyyyMMdd
        case yyyy
        case MM
        case dd
        case hhmm
    }
    
    enum ScriptType {
        case hi
        case scheduleValue
        case scheduleNil
        case ddayValue
        case ddayNil
    }
    
    enum ImageType {
        case bubbleBlackShort
        case bubbleBlackLong
        case bubbleWhiteShort
        case bubbleWhiteLong
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func dateFormatToString(date: Date, formatStyle: FormatStyle) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        switch formatStyle {
        case .yyyyMMddEaHHmm:
           dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .yyyy:
            dateFormatter.dateFormat = "yyyy"
        case .MM:
            dateFormatter.dateFormat = "MM"
        case .dd:
            dateFormatter.dateFormat = "dd"
        case .hhmm:
            dateFormatter.dateFormat = "a hh:mm"
        }
        
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func stringFormatToDate(string: String, formatStyle: FormatStyle) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
        switch formatStyle {
        case .yyyyMMddEaHHmm:
           dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .yyyy:
            dateFormatter.dateFormat = "yyyy"
        case .MM:
            dateFormatter.dateFormat = "MM"
        case .dd:
            dateFormatter.dateFormat = "dd"
        case .hhmm:
            dateFormatter.dateFormat = "a hh:mm"
        }
        let date = dateFormatter.date(from: string)
        return date
    }    
    
    func localDate(date: Date, formatStyle: FormatStyle) -> Date? {
        
        let date = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        switch formatStyle {
        case .yyyyMMddEaHHmm:
           dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .yyyy:
            dateFormatter.dateFormat = "yyyy"
        case .MM:
            dateFormatter.dateFormat = "MM"
        case .dd:
            dateFormatter.dateFormat = "dd"
        case .hhmm:
            dateFormatter.dateFormat = "a hh:mm"
        }
        
        let string = dateFormatter.string(from: date)
        let today = dateFormatter.date(from: string)
        
        return today
    }
    
    func selectScript(scriptType: ScriptType) -> String {
        switch scriptType {
        case .hi:
            return "hi".localized
        case .scheduleValue:
            return "schedule".localized
        case .scheduleNil:
            return "scheduleAddRecommend".localized
        case .ddayValue:
            return "dday".localized
        case .ddayNil:
            return "ddayAddRecommend".localized
        }
    }
    
    func days(from date: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = localDate(date: Date(), formatStyle: .yyyyMMdd)
        return calendar.dateComponents([.day], from: date, to: currentDate!).day! + 1
    }

}

