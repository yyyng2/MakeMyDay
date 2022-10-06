//
//  DdayRealmModel.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/18.
//

import UIKit

import RealmSwift

final class Dday: Object, Codable {
    
    private override init() { }
    
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
    
    enum CodingKeys: CodingKey {
        case objectId
        case title
        case date
        case pin
        case dateString
        case dayPlus
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        try container.encode(pin, forKey: .pin)
        try container.encode(dateString, forKey: .dateString)
        try container.encode(dayPlus, forKey: .dayPlus)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._objectId = try container.decode(Persisted<ObjectId>.self, forKey: .objectId)
        self._title = try container.decode(Persisted<String>.self, forKey: .title)
        self._date = try container.decode(Persisted<Date>.self, forKey: .date)
        self._pin = try container.decode(Persisted<Bool>.self, forKey: .pin)
        self._dateString = try container.decode(Persisted<String>.self, forKey: .dateString)
        self._dayPlus = try container.decode(Persisted<Bool>.self, forKey: .dayPlus)
    }
    
}
