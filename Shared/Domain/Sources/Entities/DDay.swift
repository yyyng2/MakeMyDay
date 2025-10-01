import Foundation
import SwiftData

@Model
public final class DDay {
    public var id: UUID
    public var title: String
    public var date: Date
    public var isAnniversary: Bool
    public var dayPlus: Bool
    
    public init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        isAnniversary: Bool = false,
        dayPlus: Bool = true
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.isAnniversary = isAnniversary
        self.dayPlus = dayPlus
    }
}

extension DDay {
    public func toLocalTime(date: Date) -> Date {
        let timeZoneOffset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: date))
        return date.addingTimeInterval(timeZoneOffset)
    }
    
    public func daysSince(dayPlus: Bool) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.autoupdatingCurrent
        calendar.locale = Locale.autoupdatingCurrent
        
        let localDate = calendar.startOfDay(for: toLocalTime(date: self.date))
        let currentDate = calendar.startOfDay(for: toLocalTime(date: Date()))
        
        let days = calendar.dateComponents([.day], from: localDate, to: currentDate).day!
        return dayPlus ? days + 1 : days
    }
    
    public func daysUntilAnniversary() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.autoupdatingCurrent
        calendar.locale = Locale.autoupdatingCurrent

        let currentYear = calendar.component(.year, from: toLocalTime(date: Date()))

        var anniversaryDate = calendar.date(from: DateComponents(
            year: currentYear,
            month: calendar.component(.month, from: toLocalTime(date: self.date)),
            day: calendar.component(.day, from: toLocalTime(date: self.date))
        ))!

        let today = calendar.startOfDay(for: toLocalTime(date: Date()))

        if today > anniversaryDate {
            anniversaryDate = calendar.date(byAdding: .year, value: 1, to: anniversaryDate) ?? toLocalTime(date: Date())
        }
        return -(calendar.dateComponents([.day], from: today, to: anniversaryDate).day ?? 0)
    }
    
    public func daysCalculate() -> Int {
        switch self.isAnniversary {
        case true:
            return self.daysUntilAnniversary()
        case false:
            return self.daysSince(dayPlus: self.dayPlus)
        }
    }
}
