//
//  DdayRealmModel.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/18.
//

import UIKit

import RealmSwift

final class Dday: Object{
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var pin: Bool
    @Persisted var dateString: String
    @Persisted var dayPlus: Bool
    
    convenience init(title: String, date: Date, dateString: String, dayPlus: Bool) {
        self.init()
        self.title = title
        self.date = date
        self.pin = false
        self.dateString = dateString
        self.dayPlus = dayPlus
    }
}
