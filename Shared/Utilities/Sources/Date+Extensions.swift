import Foundation

extension Date {
    public func datesInCurrentMonth() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)
        
        return range!.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    public func isSameDay(as otherDate: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
    
    public func formattedYyyyMmDd() -> String {
        return format("yyyy-MM-dd")
    }
    
    public func formattedYyyyMmDdWithWeekday() -> String {
        return format("yyyy-MM-dd (EEE)")
    }
    
    public func formattedMmDdWithWeekday() -> String {
        return format("MM-dd (EEE)")
    }
    
    public func formattedDdWithWeekday() -> String {
        return format("dd (EEE)")
    }
    
    public func formattedWeekday() -> String {
        return format("(EEE)")
    }
    
    public func formattedYyyyMmDdWithTime() -> String {
        return format("yyyy-MM-dd (EEE) a hh:mm")
    }
    
    public func formattedDdWithTime() -> String {
        return format("dd (EEE) a hh:mm")
    }
    
    public func formattedTime() -> String {
        return format("a hh:mm")
    }
    
    public func formattedDay() -> String {
        return format("dd")
    }
    
    private func format(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public func toLocalTime() -> Date {
        let timeZoneOffset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))
        return self.addingTimeInterval(timeZoneOffset)
    }
    
    public func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale.autoupdatingCurrent
        return formatter.string(from: self)
    }
    
    public func getNextAnniversaryCount() -> String {
        let calendar = Calendar.current
        let startDate = self.toLocalTime()
        let now = Date().toLocalTime()
        
        if startDate > now { return 0.anniversarySuffix() }
        
        let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
        let nowComponents = calendar.dateComponents([.year, .month, .day], from: now)
        
        guard let startYear = startComponents.year,
              let startMonth = startComponents.month,
              let startDay = startComponents.day,
              let nowYear = nowComponents.year else { return 0.anniversarySuffix() }
        
        var count = nowYear - startYear
        
        var thisYearAnniversary = calendar.date(from: DateComponents(year: nowYear, month: startMonth, day: startDay))
        if thisYearAnniversary == nil {
            if startMonth == 2 && startDay == 29 {
                thisYearAnniversary = calendar.date(from: DateComponents(year: nowYear, month: 2, day: 28))
            }
        }
        
        if let anniv = thisYearAnniversary {
            if now < anniv {
                count -= 1
            }
        }
        
        let countYear = Int(max(0, count)) + 1
        return countYear.anniversarySuffix()
    }
}
