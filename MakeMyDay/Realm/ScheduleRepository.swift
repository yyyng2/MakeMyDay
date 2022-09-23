//
//  ScheduleRepository.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/16.
//

import UIKit

import RealmSwift

protocol ScheduleRepositoryType {
    func fetchFilter(text: String) -> Results<Schedule>
    func fetchFilterImportant() -> Results<Schedule>
    func fetchFilterUnimportant() -> Results<Schedule>
    func fetch() -> Results<Schedule>
    func deleteRecord(record: Schedule)
    func addRecord(record: Schedule)
}

final class ScheduleRepository: ScheduleRepositoryType {
    
     
    let localRealm = try! Realm() // struct
    
    func addRecord(record: Schedule) {
        do{
            try localRealm.write{
                localRealm.add(record)
            }
        } catch let error {
            print(error)
        }
    }

    func fetch() -> Results<Schedule> {
        
        return localRealm.objects(Schedule.self).sorted(byKeyPath: "date", ascending: true)
      
    }
    
    func fetchImportant() -> Results<Schedule> {
        
        return localRealm.objects(Schedule.self).sorted(byKeyPath: "important", ascending: true)
      
    }
    
    func fetchFilterDate(date: Date) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("date == %@", date).sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilterDateString(formatString: String) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("dateString CONTAINS[c] '\(formatString)'").sorted(byKeyPath: "date", ascending: true)
    }
        
    func fetchFilter(text: String) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("allText CONTAINS[c] '\(text)'").sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilterImportant() -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("dday == true").sorted(byKeyPath: "date", ascending: false)
    }
    func fetchFilterUnimportant() -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("dday == false").sorted(byKeyPath: "date", ascending: false)
    }
    
    func deleteById(id: ObjectId) {
//        let task = localRealm.objects(UserMemo.self).filter("objectId == \(id)")
        let user = localRealm.object(ofType: Schedule.self, forPrimaryKey: id)
        do {
            try localRealm.write {
                localRealm.delete(user!)
            }
        } catch let error {
            print(error)
        }
    }
    
//    func updateImportant(record: Schedule) {
//        do{
//            try localRealm.write {
//                //하나의 레코드에서 특정 컬럼 하나만 변경
//                record.dday = !record.dday
//            }
//        } catch let error {
//            print(error)
//        }
//    }
    
    func updateRecord(id: ObjectId, record: Schedule) {
        
        do{
            let task = localRealm.object(ofType: Schedule.self, forPrimaryKey: id)
            try localRealm.write {
                task?.date = record.date
                task?.content = record.content
                task?.title = record.title
                task?.allText = record.allText
                task?.dateString = record.dateString
            }
        } catch let error {
            print(error)
        }
        
    }
    
    func deleteRecord(record: Schedule) {
        do {
            try localRealm.write {
                localRealm.delete(record)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteEmptyRecord() {
        let emptyRealm = localRealm.objects(Schedule.self).filter("allText == ''")
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

