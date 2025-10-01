import Foundation
import SwiftData

@Model
public final class Schedule: Equatable {
    public var id: UUID
    public var title: String
    public var date: Date
    public var isWeeklyRepeat: Bool
    public var showInCalendar: Bool
    
    public init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        isWeeklyRepeat: Bool,
        showInCalendar: Bool,
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.isWeeklyRepeat = isWeeklyRepeat
        self.showInCalendar = showInCalendar
    }
    
    public static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.date == rhs.date &&
        lhs.isWeeklyRepeat == rhs.isWeeklyRepeat &&
        lhs.showInCalendar == rhs.showInCalendar
    }
}
