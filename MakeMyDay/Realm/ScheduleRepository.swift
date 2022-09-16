//
//  ScheduleRepository.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/16.
//

import RealmSwift
import SwiftUI

//protocol ScheduleRepositoryType{
//    func fetchFilter(text: String) -> Results<Schedule>
//    func fetchFilterPinned() -> Results<Schedule>
//    func fetchFilterUnPinned() -> Results<Schedule>
//    func fetch() -> Results<Schedule>
//    func updatePin(record: Schedule)
//    func deleteRecord(record: Schedule)
//    func addRecord(record: Schedule)
//}
//
//final class ScheduleRepository: ScheduleRepositoryType{
//    
//    let localRealm = try! Realm() // struct
//    
//    func addRecord(record: Schedule) {
//        do{
//            try localRealm.write{
//                localRealm.add(record)
//            }
//        } catch let error {
//            print(error)
//        }
//    }
//    
//    func fetch() -> Results<Schedule> {
//        return localRealm.objects(Schedule.self).sorted(byKeyPath: "regdate", ascending: true)
//    }
//    
//    func fetchFilter(text: String) -> Results<Schedule>{
//        return localRealm.objects(Schedule.self).filter("allText CONTAINS[c] '\(text)'").sorted(byKeyPath: "regdate", ascending: false)
//    }
//    
//    func fetchFilterPinned() -> Results<Schedule>{
//        return localRealm.objects(Schedule.self).filter("pin == true").sorted(byKeyPath: "regdate", ascending: false)
//    }
//    func fetchFilterUnPinned() -> Results<Schedule>{
//        return localRealm.objects(Schedule.self).filter("pin == false").sorted(byKeyPath: "regdate", ascending: false)
//    }
//    
//    func deleteById(id: ObjectId){
////        let task = localRealm.objects(UserMemo.self).filter("objectId == \(id)")
//        let user = localRealm.object(ofType: Schedule.self, forPrimaryKey: id)
//        do{
//            try localRealm.write{
//                localRealm.delete(user!)
//            }
//        }catch let error {
//            print(error)
//        }
//    }
//    
//    func updatePin(record: Schedule) {
//        do{
//            try localRealm.write {
//                //하나의 레코드에서 특정 컬럼 하나만 변경
//                record.pin = !record.pin
//            }
//        } catch let error{
//            print(error)
//        }
//        
//    }
//    
//    func updateRecord(id: ObjectId, record: Schedule) {
//        
//        do{
//            let task = localRealm.object(ofType: Schedule.self, forPrimaryKey: id)
//            try localRealm.write {
//                task?.regdate = record.regdate
//                task?.allText = record.allText
//                task?.content = record.content
//                task?.title = record.title
//            }
//        } catch let error{
//            print(error)
//        }
//        
//    }
//    
//    func deleteRecord(record: Schedule){
//        do{
//            try localRealm.write{
//                localRealm.delete(record)
//            }
//        }catch let error {
//            print(error)
//        }
//    }
//    
//    func deleteEmptyRecord(){
//        let emptyRealm = localRealm.objects(Schedule.self).filter("allText == ''")
//        do{
//            try localRealm.write{
//                localRealm.delete(emptyRealm)
//            }
//        }catch let error{
//            print(error)
//            
//        }
//    }
//    
//}
