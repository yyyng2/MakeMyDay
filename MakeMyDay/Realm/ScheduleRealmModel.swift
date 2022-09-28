//
//  ScheduleRealmModel.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/16.
//

import UIKit

import RealmSwift


final class Schedule: Object{
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var date: Date
    @Persisted var dateString: String
    
    convenience init(title: String, content: String?, date: Date, dateString: String) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.dateString = dateString
    }
}


