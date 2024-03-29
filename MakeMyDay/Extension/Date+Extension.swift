//
//  Date+Extension.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//


import Foundation

extension Date {
  
    public func dateFormattedToStringYyyymmddeahhmm() -> String {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
       
        
        return dateFormatter.string(from: self)
    }
    
    public func dateFormattedToDateYyyymmddeahhmm() -> Date {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
       
        let string = dateFormatter.string(from: self)
        
        return string.stringFormatToDateYyyymmddeahhmm()!
    }
    
    public func dateFormattedToStringYyyymmdd() -> String {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        
        return dateFormatter.string(from: self)
    }
    
    public func dateFormattedToDateYyyymmdd() -> Date {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        let string = dateFormatter.string(from: self)
        
        return string.stringFormatToDateYyyymmdd()!
    }
    
    public func dateFormattedToStringAhhmm() -> String {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "a hh:mm"
       
        
        return dateFormatter.string(from: self)
    }
    
    public func dateFormattedToIntHh() -> Int {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "HH"
       
        let string = dateFormatter.string(from: self)
        
        return Int(string)!
    }
    
    public func dateFormattedToIntMm() -> Int {
        
        let dateFormatter = DateFormatter()
  
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "mm"
       
        let string = dateFormatter.string(from: self)
        
        return Int(string)!
    }
    
}
