//
//  ScheduleRealmModel.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/16.
//

import UIKit

import RealmSwift

final class Schedule: Object, Codable {
    
    private override init() { }
    
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
    
    enum CodingKeys: CodingKey {
        case objectId
        case title
        case content
        case date
        case dateString
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(date, forKey: .date)
        try container.encode(dateString, forKey: .dateString)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._objectId = try container.decode(Persisted<ObjectId>.self, forKey: .objectId)
        self._title = try container.decode(Persisted<String>.self, forKey: .title)
        self._content = try container.decode(Persisted<String?>.self, forKey: .content)
        self._date = try container.decode(Persisted<Date>.self, forKey: .date)
        self._dateString = try container.decode(Persisted<String>.self, forKey: .dateString)
    }
    
}


