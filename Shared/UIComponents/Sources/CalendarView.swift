import SwiftUI
import Domain
import Utilities
import Resources

public struct CalendarView: View {
    public let currentDate: Date
    public let selectedDate: Date
    public let schedules: [Schedule]
    public let onDateSelected: (Date) -> Void
    public let onPreviousMonth: () -> Void
    public let onNextMonth: () -> Void
    public let onPreviousYear: () -> Void
    public let onNextYear: () -> Void
    
    public let calendar = Calendar.current
    public let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM"
        return formatter
    }()
    
    @State private var isWeekMode: Bool = false
    
    public init(
        currentDate: Date,
        selectedDate: Date,
        schedules: [Schedule],
        onDateSelected: @escaping (Date) -> Void,
        onPreviousMonth: @escaping () -> Void,
        onNextMonth: @escaping () -> Void,
        onPreviousYear: @escaping () -> Void,
        onNextYear: @escaping () -> Void
    ) {
        self.currentDate = currentDate
        self.selectedDate = selectedDate
        self.schedules = schedules
        self.onDateSelected = onDateSelected
        self.onPreviousMonth = onPreviousMonth
        self.onNextMonth = onNextMonth
        self.onPreviousYear = onPreviousYear
        self.onNextYear = onNextYear
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: onPreviousYear) {
                    Image(systemName: "chevron.left.2")
                        .font(.title2)
                }
                
                Spacer()
                
                Button(action: onPreviousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Spacer()
                
                Text(dateFormatter.string(from: currentDate))
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: onNextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                
                Spacer()
                
                Button(action: onNextYear) {
                    Image(systemName: "chevron.right.2")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            HStack {
                ForEach(Array(["calendar_sunday".localized(), "calendar_monday".localized(), "calendar_tuesday".localized(), "calendar_wednesday".localized(), "calendar_thursday".localized(), "calendar_friday".localized(), "calendar_saturday".localized()].enumerated()), id: \.offset) { index, day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(index == 0 ? .red : index == 6 ? .blue : .accentColor)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 5) {
                ForEach(Array((isWeekMode ? weekDays : calendarDays).enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        VStack(spacing: 2) {
                            Text("\(calendar.component(.day, from: date))")
                                .font(.system(size: 16))
                                .fontWeight(calendar.isDate(date, inSameDayAs: selectedDate) ? .bold : .regular)
                                .foregroundColor(
                                    calendar.isDate(date, inSameDayAs: selectedDate) ? Color(ResourcesAsset.Assets.baseForeground.color) :
                                    calendar.isDate(date, equalTo: currentDate, toGranularity: .month) ? .primary : .secondary
                                )
                                .frame(width: 30, height: 30)
                                .background(
                                    calendar.isDate(date, inSameDayAs: selectedDate) ?
                                    Color.accentColor : Color.clear
                                )
                                .clipShape(Circle())
                            
                            // 스케줄 표시 점
                            Circle()
                                .fill(hasVisibleSchedule(on: date) ? Color.red : Color.clear)
                                .frame(width: 4, height: 4)
                        }
                        .onTapGesture {
                            onDateSelected(date)
                        }
                    } else {
                        Color.clear
                            .frame(width: 30, height: 36)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: isWeekMode)
                        
            }
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isWeekMode.toggle()
                }
            }) {
                Image(systemName: isWeekMode ? "chevron.down" : "chevron.up")
                    .font(.headline)
                    .foregroundColor(Color(ResourcesAsset.Assets.baseFontColor.color))
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
        }
        .padding()
    }
    
    private var calendarDays: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else {
            return []
        }
        
        let firstOfMonth = monthInterval.start
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let leadingEmptyDays = (firstWeekday - 1) % 7
        
        var days: [Date?] = Array(repeating: nil, count: leadingEmptyDays)
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 0
        
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }
    
    private var weekDays: [Date?] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: selectedDate) else {
            return []
        }
        
        var days: [Date?] = []
        let startOfWeek = weekInterval.start
        
        for day in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                days.append(date)
            }
        }
        
        return days
    }
    
    private func hasVisibleSchedule(on date: Date) -> Bool {
        return schedules.contains { schedule in
            let isSameDay = calendar.isDate(schedule.date, inSameDayAs: date)
            let isWeeklyMatch = schedule.isWeeklyRepeat &&
                               calendar.component(.weekday, from: schedule.date) == calendar.component(.weekday, from: date)
            
            return (isSameDay || isWeeklyMatch) && schedule.showInCalendar
        }
    }
}
