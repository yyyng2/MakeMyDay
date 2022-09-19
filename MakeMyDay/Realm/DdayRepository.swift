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
        return localRealm.objects(Dday.self).filter("allText CONTAINS[c] '\(text)'").sorted(byKeyPath: "date", ascending: false)
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
    
    func updateRecord(id: ObjectId, record: Dday) {
        
        do {
            let task = localRealm.object(ofType: Dday.self, forPrimaryKey: id)
            try localRealm.write {
                task?.date = record.date
                task?.title = record.title
                task?.pin = record.pin
                task?.dateString = record.dateString
            }
        } catch let error{
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
        let emptyRealm = localRealm.objects(Dday.self).filter("allText == ''")
        do {
            try localRealm.write {
                localRealm.delete(emptyRealm)
            }
        } catch let error {
            print(error)
            
        }
    }
    
}
