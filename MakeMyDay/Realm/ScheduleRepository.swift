//
//  ScheduleRepository.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/16.
//

import UIKit
import WidgetKit

import RealmSwift

protocol ScheduleRepositoryType {
    func fetch() -> Results<Schedule>
    func deleteRecord(record: Schedule)
    func addRecord(record: Schedule)
}

final class ScheduleRepository: ScheduleRepositoryType {
    
     var localRealm: Realm {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.io.github.yyyng2.MakeMyDay")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 0)
        do {
            return try Realm(configuration: config)
        } catch let error as NSError {
            print("error \(error.debugDescription)")
            fatalError("Can't continue further, no Realm available")
        }
    }
    
    func addRecord(record: Schedule) {
        do {
            try localRealm.write {
                localRealm.add(record)
            }
        } catch let error {
            print(error)
        }
        WidgetCenter.shared.reloadAllTimelines()
    }

    func fetch() -> Results<Schedule> {
        
        return localRealm.objects(Schedule.self).sorted(byKeyPath: "date", ascending: true)
      
    }
    
    func fetchFilterDate(date: Date) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("date == %@", date).sorted(byKeyPath: "date", ascending: true)
    }
    
    func fetchFilterDateString(formatString: String) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("dateString CONTAINS[c] '\(formatString)'").sorted(byKeyPath: "date", ascending: true)
    }
    
    func deleteById(id: ObjectId) {

        let task = localRealm.object(ofType: Schedule.self, forPrimaryKey: id)
        do {
            try localRealm.write {
                localRealm.delete(task!)
            }
        } catch let error {
            print(error)
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func updateRecord(id: ObjectId, record: Schedule) {
        
        do{
            let task = localRealm.object(ofType: Schedule.self, forPrimaryKey: id)
            try localRealm.write {
                task?.date = record.date
                task?.content = record.content
                task?.title = record.title
                task?.dateString = record.dateString
            }
        } catch let error {
            print(error)
        }
        
        WidgetCenter.shared.reloadAllTimelines()
        
    }
    
    func deleteRecord(record: Schedule) {
        do {
            try localRealm.write {
                localRealm.delete(record)
            }
        } catch let error {
            print(error)
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func deleteEmptyRecord() {
        let emptyRealm = localRealm.objects(Schedule.self).filter("title == '' AND content == ''")
        do {
            try localRealm.write {
                localRealm.delete(emptyRealm)
            }
        } catch let error {
            print(error)
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func deleteAll() {
        try! localRealm.write {
            localRealm.deleteAll()
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}

