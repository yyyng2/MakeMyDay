//
//  ScheduleRealmModel.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/16.
//

import RealmSwift
import UIKit

final class Schedule: Object{
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var scheduleTitle: String
    @Persisted var scheduleContent: String?
    @Persisted var scheduleDate = Date()
    @Persisted var ddayPin: Bool
    
    convenience init(allText: String, title: String, content: String?, regdate: Date) {
        self.init()
        self.scheduleTitle = title
        self.scheduleContent = content
        self.scheduleDate = regdate
        self.ddayPin = false
    }
}
