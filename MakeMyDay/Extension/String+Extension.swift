//
//  String+Extension.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/28.
//

import Foundation

extension String {
    public func stringFormatToDateYyyymmddeahhmm() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
  
        dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
       
        let date = dateFormatter.date(from: self)
        return date
    }
    
    public func stringFormatToDateYyyymmdd() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
 
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        let date = dateFormatter.date(from: self)
        return date
    }
    
    public func stringFormatToDateUTCYyyymmdd() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        let date = dateFormatter.date(from: self)
        return date
    }
    
    public func stringFormatToDateAHhmm() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        dateFormatter.dateFormat = "a hh:mm"
     
        let date = dateFormatter.date(from: self)
        return date
    }
    
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
    func localized(with: String) -> String{
        return String(format: self.localized, with)
    }
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}
