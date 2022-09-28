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
    
    func stringFormatToDateYyyymmdd() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
 
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        let date = dateFormatter.date(from: self)
        return date
    }
}
