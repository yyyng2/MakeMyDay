//
//  DdayRepository.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/18.
//

import UIKit

import RealmSwift

protocol DdayRepositoryType {
    func fetchFilter(text: String) -> Results<Dday>
    func fetchFilterPinned() -> Results<Dday>
    func fetchFilterUnPinned() -> Results<Dday>
    func fetch() -> Results<Dday>
    func updatePin(record: Dday)
    func deleteRecord(record: Dday)
    func addRecord(record: Dday)
}

final class DdayRepository: DdayRepositoryType {
    
    let localRealm = try! Realm() // struct
    
    func addRecord(record: Dday) {
        do {
            try localRealm.write {
                localRealm.add(record)
            }
        } catch let error {
            print(error)
        }
    }

    func fetch() -> Results<Dday> {
        
        return localRealm.objects(Dday.self).sorted(byKeyPath: "date", ascending: true)
      
    }
    
    func fetchFilterDateString(formatDate: String) -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("dateString CONTAINS[c] '\(formatDate)'").sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilterDate(date: Date) -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("date == %@", date).sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilter(text: String) -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("title CONTAINS[c] '\(text)'").sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilterPinned() -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("pin == true").sorted(byKeyPath: "date", ascending: false)
    }
    func fetchFilterUnPinned() -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("pin == false").sorted(byKeyPath: "date", ascending: false)
    }
    
    func deleteById(id: ObjectId) {

        let user = localRealm.object(ofType: Dday.self, forPrimaryKey: id)
        do {
            try localRealm.write {
                localRealm.delete(user!)
            }
        } catch let error {
            print(error)
        }
    }
    
    func updatePin(record: Dday) {
        do {
            try localRealm.write {
                //하나의 레코드에서 특정 컬럼 하나만 변경
                record.pin = !record.pin
            }
        } catch let error {
            print(error)
        }
        
    }
    
    enum FormatStyle {
        case yyyyMMddEaHHmm
        case yyyyMMdd
        case yyyy
        case MM
        case dd
        case hhmm
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
    
    func days(record: Dday) -> Int {
        let date = stringFormatToDate(string: record.dateString, formatStyle: .yyyyMMdd)!
        switch record.dayPlus {
        case true:
            let calendar = Calendar.current
            let currentDate = localDate(date: Date(), formatStyle: .yyyyMMdd)
            return calendar.dateComponents([.day], from: date, to: currentDate!).day! + 1
        case false:
            let calendar = Calendar.current
            let currentDate = localDate(date: Date(), formatStyle: .yyyyMMdd)
            return calendar.dateComponents([.day], from: date, to: currentDate!).day!
        }
     
     
    }
    
    func updateRecord(id: ObjectId, record: Dday) {
        
        do{
            let task = localRealm.object(ofType: Dday.self, forPrimaryKey: id)
            try localRealm.write {
                task?.date = record.date
                task?.title = record.title
                task?.dateString = record.dateString
                task?.dayPlus = record.dayPlus
            }
        } catch let error {
            print(error)
        }
        
    }
    
    func deleteRecord(record: Dday){
        do {
            try localRealm.write {
                localRealm.delete(record)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteEmptyRecord() {
        let emptyRealm = localRealm.objects(Dday.self).filter("title == ''")
        do {
            try localRealm.write {
                localRealm.delete(emptyRealm)
            }
        } catch let error {
            print(error)
            
        }
    }
    
    func deleteAll() {
        try! localRealm.write {
            localRealm.deleteAll()
        }
    }
}
