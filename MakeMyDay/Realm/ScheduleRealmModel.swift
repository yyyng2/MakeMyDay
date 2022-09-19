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
    @Persisted var allText: String
    
    convenience init(allText: String, title: String, content: String?, date: Date) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.allText = allText
    }
}


